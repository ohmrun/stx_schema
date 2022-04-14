package stx.schema.declare;

interface DeclareRecordSchemaApi extends DeclareSchemaApi{
  public final fields : Procurements;
  public final ident  : Ident;
}
class  DeclareRecordSchemaCls implements DeclareRecordSchemaApi extends DeclareSchemaConcrete{
  public function new(ident,fields,meta,validation){
    this.fields     = fields;
    this.validation = validation;
    super(ident,meta);
  }
  public final fields : Procurements;
  public function get_validation(){ return this.validation; }
}
@:forward abstract DeclareRecordSchema(DeclareRecordSchemaApi) from DeclareRecordSchemaApi to DeclareRecordSchemaApi{
  public function new(self) this = self;
  static public var _(default,never) = DeclareRecordSchemaLift;
  @:noUsing static public function lift(self:DeclareRecordSchemaApi):DeclareRecordSchema return new DeclareRecordSchema(self);

  @:noUsing static public function make(ident:Ident,fields:Procurements,?meta,?validation:Validations){
    return lift(new DeclareRecordSchemaCls(
      ident,
      fields,
      __.option(meta).defv(Empty),
      validation
    ));
  }
  @:noUsing static public function make0(name:String,pack,fields:Procurements,?meta,?validation){
    return make(
      Ident.make(name,pack),
      fields,
      meta,
      validation
    );
  }
  public function prj():DeclareRecordSchemaApi return this;
  private var self(get,never):DeclareRecordSchema;
  private function get_self():DeclareRecordSchema return lift(this);

  public function resolve(state:TyperContext):Schema{
    __.log().debug('resolve record');
    final fieldsI = this.fields.map(
      (field:Procure) -> {
        __.log().debug(_ -> _.thunk( () -> field));
        final ref = state.get(field.type.id).fold(
          x   -> SchemaRef.fromSchema(x),
          ()  -> field.type.resolve(state)
        );
        __.log().debug(_ -> _.thunk( () -> ref));
        return field.with_type(ref);
      }
    );
    final result = make(Ident.make(this.id.name,this.id.pack),fieldsI,this.validation);
    state.put(SchRecord(result));
    return SchRecord(result);
  }
  public function toString(){
    final thiz = this.id.toString();
    final rest = @:privateAccess this.fields.map(
      procurement -> procurement.toString()      
    ).prj().join(",");
    return '$thiz($rest)';
  }
  public function toSchema(){
    return Schema.lift(SchRecord(this));
  }
}
class DeclareRecordSchemaLift{
  static public function to_self_constructor(self:DeclareRecordSchema){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.declare.DeclareRecordSchema.make'),
      [
        e.Call(
          e.Path('stx.Ident.make'),
          [
            e.Const(c -> c.String(self.id.name)),
            e.ArrayDecl(__.option(self.id.pack).defv([]).prj().map(str -> e.Const(c -> c.String(str))))
          ]
        ),
        self.fields.to_self_constructor()
      ]
    );
  }
}