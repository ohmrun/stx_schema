package stx.schema;

typedef SchemaAnonDeclarationDef = {
  final fields : Cluster<Field>;
}
abstract SchemaAnonDeclaration(SchemaAnonDeclarationDef) from SchemaAnonDeclarationDef to SchemaAnonDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:SchemaAnonDeclarationDef):SchemaAnonDeclaration return new SchemaAnonDeclaration(self);

  public function prj():SchemaAnonDeclarationDef return this;
  private var self(get,never):SchemaAnonDeclaration;
  private function get_self():SchemaAnonDeclaration return lift(this);
}