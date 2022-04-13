package stx.schema;

typedef SchemaRecordDeclarationDef = SchemaDeclarationDef & {
  final fields : Procurements;
}
@:forward abstract SchemaRecordDeclaration(SchemaRecordDeclarationDef) from SchemaRecordDeclarationDef to SchemaRecordDeclarationDef{
  public function new(self) this = self;
  static public var _(default,never) = SchemaRecordDeclarationLift;
  @:noUsing static public function lift(self:SchemaRecordDeclarationDef):SchemaRecordDeclaration return new SchemaRecordDeclaration(self);

  @:noUsing static public function make(ident:Ident,fields:Procurements,?validation:Validations){
    return lift({
      id          : Identity.fromIdent(ident),
      fields      : fields,
      validation  : validation
    });
  }
  @:noUsing static public function make0(name:String,pack,fields:Procurements,?validation){
    return make(
      Ident.make(name,pack),
      fields,
      validation
    );
  }
  public function prj():SchemaRecordDeclarationDef return this;
  private var self(get,never):SchemaRecordDeclaration;
  private function get_self():SchemaRecordDeclaration return lift(this);

  public function identity(){
    return this.id;
  }
  public function resolve(state:TyperContext):Schema{
    __.log().debug('resolve record');
    final fieldsI = this.fields.map(
      (field:Procurement) -> {
        __.log().debug(_ -> _.thunk( () -> field));
        final ref = state.get(field.type.identity()).fold(
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
    final thiz = identity().toString();
    final rest = @:privateAccess this.fields.map(
      procurement -> procurement.toString()      
    ).prj().join(",");
    return '$thiz($rest)';
  }
  public function toSchema(){
    return Schema.lift(SchRecord(this));
  }
}
class SchemaRecordDeclarationLift{
  static public function to_self_constructor(self:SchemaRecordDeclaration){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.SchemaRecordDeclaration.make'),
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