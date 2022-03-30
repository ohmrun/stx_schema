package stx.schema;

typedef SchemaRecordDeclarationDef = SchemaDeclarationDef & {
  final fields : Procurements;
}
@:forward abstract SchemaRecordDeclaration(SchemaRecordDeclarationDef) from SchemaRecordDeclarationDef to SchemaRecordDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:SchemaRecordDeclarationDef):SchemaRecordDeclaration return new SchemaRecordDeclaration(self);

  static public function make(ident,fields,?validation){
    return lift({
      id          : Identity.fromIdent(ident),
      fields      : fields,
      validation  : validation
    });
  }
  static public function make0(name:String,pack,fields:Procurements,?validation){
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
  public function resolve(state:Schemata):Schema{
    __.log().debug('resolve record');
    final fieldsI = this.fields.map(
      (field:Procurement) -> {
        __.log().debug(_ -> _.thunk( () -> field));
        final ref = state.get(field.type.identity()).fold(
          x   -> SchemaRef.fromSchema(x),
          ()  -> __.tracer()(field.type.resolve(state))
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
}