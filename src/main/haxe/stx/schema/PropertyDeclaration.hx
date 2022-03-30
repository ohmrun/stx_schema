package stx.schema;

typedef PropertyDeclarationDef = stx.schema.WithValidationDef & {
  final type        : SchemaRef;
}
@:forward abstract PropertyDeclaration(PropertyDeclarationDef) from PropertyDeclarationDef to PropertyDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:PropertyDeclarationDef):PropertyDeclaration return new PropertyDeclaration(self);

  public function prj():PropertyDeclarationDef return this;
  private var self(get,never):PropertyDeclaration;
  private function get_self():PropertyDeclaration return lift(this);

  @:from static public function fromSchemaDeclarationDef(self:SchemaDeclarationDef){
    return lift({
      type : SchemaRef.fromSchemaDeclaration(self)
    });
  }
  @:from static public function fromSchema(self:Schema){
    return lift({
      type : SchemaRef.fromSchema(self)
    });
  }
  public function with_type(ref:SchemaRef){
    return lift({
      validation  : this.validation,
      type        : ref
    });
  }
}