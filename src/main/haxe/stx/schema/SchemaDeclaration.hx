package stx.schema;

typedef SchemaDeclarationDef = WithValidationDef & SchemaIdentDef;

@:forward abstract SchemaDeclaration(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:SchemaDeclarationDef):SchemaDeclaration return new SchemaDeclaration(self);

  static public function make(name,pack,?validation){
    return lift({
      name        : name,
      pack        : pack,
      validation  : validation
    });
  }
  public function prj():SchemaDeclarationDef return this;
  private var self(get,never):SchemaDeclaration;
  private function get_self():SchemaDeclaration return lift(this);
}