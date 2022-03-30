package stx.schema.term;

abstract SchemaFloat(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaFloatLift;
  static public function make(){
    return new SchemaFloat(
      SchemaDeclaration.make0(
        'Float',
        ['std'],
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toSchemaDeclaration(){
    return SchemaDeclaration.lift(this);
  }
}
class SchemaFloatLift{
  static public function validate(){
    return new stx.schema.validation.term.Float();
  }
}