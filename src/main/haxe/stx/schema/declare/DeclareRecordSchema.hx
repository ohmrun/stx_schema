package stx.schema.declare;

interface DeclareRecordSchemaApi extends DeclareNominativeSchemaApi extends DeclareIdentifiableSchemaApi{
  public final fields : Procurements;
}
class DeclareRecordSchemaCls implements DeclareRecordSchemaApi extends DeclareNominativeSchemaCls{
  public function new(ident,fields,validation,meta){
    this.fields     = fields;
    super(ident,validation,meta);
  }
  public final fields : Procurements;
  public var identity(get,null):Identity;
  public function get_identity():Identity{
    return identity;
  }
}
@:transitive @:forward abstract DeclareRecordSchema(DeclareRecordSchemaApi) from DeclareRecordSchemaApi to DeclareRecordSchemaApi{
  public function new(self) this = self;
  static public var _(default,never) = DeclareRecordSchemaLift;
  @:noUsing static public function lift(self:DeclareRecordSchemaApi):DeclareRecordSchema return new DeclareRecordSchema(self);

  @:noUsing static public function make(ident:Ident,fields:Procurements,?validation:Validations,?meta:PExpr<Primitive>):DeclareRecordSchema{
    return lift(new DeclareRecordSchemaCls(
      ident,
      fields,
      validation,
      meta    
    ));
  }
  @:noUsing static public function make0(name:String,pack:Way,fields:Procurements,?meta:PExpr<Primitive>,?validation:Validations):DeclareRecordSchema{
    return make(
      Ident.make(name,pack),
      fields,
      validation,
      meta
    );
  }
  public function prj():DeclareRecordSchemaApi return this;
  private var self(get,never):DeclareRecordSchema;
  private function get_self():DeclareRecordSchema return lift(this);

  // public function resolve(state:TyperContext):Future<LVar<Schema>>{
  //   // __.log().debug('resolve record');
  //   // final fieldsI = this.fields.map(
  //   //   (field:Procure) -> {
  //   //     __.log().debug(_ -> _.thunk( () -> field));
  //   //     final ref = state.get(field.type.identity).fold(
  //   //       x   -> SchemaRef.fromSchema(x),
  //   //       ()  -> field.type.resolve(state)
  //   //     );
  //   //     __.log().trace(_ -> _.thunk( () -> ref));
  //   //     return field.with_type(ref);
  //   //   }
  //   // );
  //   // final result = make(Ident.make(this.identity.name,this.identity.pack),fieldsI,this.validation);
  //   // state.put(SchRecord(result));
  //   // return SchRecord(result);
  //   return throw UNIMPLEMENTED;
  // }
  public function toString(){
    final thiz = this.identity.toString();
    final rest = @:privateAccess this.fields.toIter().map(
      procurement -> procurement.toString()      
    ).lfold1((m,n) -> "$m,$n");

    return '$thiz($rest)';
  }
  public function toSchema(){
    return Schema.lift(SchRecord(this));
  }
}
class DeclareRecordSchemaLift{
  static public function denote(self:DeclareRecordSchema){
    // final e = __.g().expr();
    // return e.Call(
    //   e.Path('stx.schema.declare.DeclareRecordSchema.make'),
    //   [
    //     e.Call(
    //       e.Path('stx.Ident.make'),
    //       [
    //         e.Const(c -> c.String(self.identity.name)),
    //         e.ArrayDecl(__.option(self.identity.pack).defv([]).prj().map(str -> e.Const(c -> c.String(str))))
    //       ]
    //     ),
    //     self.fields.denote()
    //   ]
    // );
    return throw UNIMPLEMENTED;
  }
}