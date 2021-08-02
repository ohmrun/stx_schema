package stx.schema;

typedef SchemaRecordDeclarationDef = SchemaDeclarationDef & {
  final fields : Cluster<Field>;
}
@:forward abstract SchemaRecordDeclaration(SchemaRecordDeclarationDef) from SchemaRecordDeclarationDef to SchemaRecordDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:SchemaRecordDeclarationDef):SchemaRecordDeclaration return new SchemaRecordDeclaration(self);

  static public function make(name,pack,fields,?validation){
    return lift({
      name        : name,
      pack        : pack,
      fields      : fields,
      validation  : validation
    });
  }
  public function prj():SchemaRecordDeclarationDef return this;
  private var self(get,never):SchemaRecordDeclaration;
  private function get_self():SchemaRecordDeclaration return lift(this);
}