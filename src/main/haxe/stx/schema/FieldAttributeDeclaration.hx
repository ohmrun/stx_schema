package stx.schema;

typedef FieldAttributeDeclarationDef = FieldPropertyDeclarationDef & {
  final relation   : SchemaRelationSum;
  final inverse    : String;
}
@:forward abstract FieldAttributeDeclaration(FieldAttributeDeclarationDef) from FieldAttributeDeclarationDef to FieldAttributeDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:FieldAttributeDeclarationDef):FieldAttributeDeclaration return new FieldAttributeDeclaration(self);
  static public function make(name,type,relation,inverse,?validation){
    return lift({
      name        : name,
      type        : type,
      relation    : relation,
      inverse     : inverse,
      validation  : __.option(validation).defv(Cluster.unit())
    });
  }
  public function prj():FieldAttributeDeclarationDef return this;
  private var self(get,never):FieldAttributeDeclaration;
  private function get_self():FieldAttributeDeclaration return lift(this);
}