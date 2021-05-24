package stx.schema;

typedef FieldPropertyDeclarationDef = WithValidationDef & {
  final name        : String;
  final type        : SchemaRef;
}
@:forward abstract FieldPropertyDeclaration(FieldPropertyDeclarationDef) from FieldPropertyDeclarationDef to FieldPropertyDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:FieldPropertyDeclarationDef):FieldPropertyDeclaration return new FieldPropertyDeclaration(self);
  static public function make(name,type,?validation){
    return lift({
      name : name,
      type : type,
      validation : __.option(validation).defv([])
    });
  }
  public function prj():FieldPropertyDeclarationDef return this;
  private var self(get,never):FieldPropertyDeclaration;
  private function get_self():FieldPropertyDeclaration return lift(this);
}