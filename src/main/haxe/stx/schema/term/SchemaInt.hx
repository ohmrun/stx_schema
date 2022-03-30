package stx.schema.term;

abstract SchemaInt(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaIntLift;
  static public function make(){
    return new SchemaInt(
      SchemaDeclaration.make0(
        'Int',
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
class SchemaIntLift{
  static public function validate(){
    return new stx.schema.validation.term.Int();
  }
}