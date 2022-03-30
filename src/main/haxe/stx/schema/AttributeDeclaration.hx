package stx.schema;

typedef AttributeDeclarationDef = PropertyDeclarationDef & {
  final relation   : SchemaRelationSum;
  final inverse    : String;
}
@:forward abstract AttributeDeclaration(AttributeDeclarationDef) from AttributeDeclarationDef to AttributeDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:AttributeDeclarationDef):AttributeDeclaration return new AttributeDeclaration(self);

  public function prj():AttributeDeclarationDef return this;
  private var self(get,never):AttributeDeclaration;
  private function get_self():AttributeDeclaration return lift(this);

  public function with_type(ref:SchemaRef){
    return lift({
      validation  : this.validation,
      relation    : this.relation,
      inverse     : this.inverse,
      type        : ref
    });
  }
}