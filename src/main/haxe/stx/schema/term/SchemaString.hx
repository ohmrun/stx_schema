package stx.schema.term;

abstract SchemaString(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaStringLift;
  @:noUsing static public function make(){
    return new SchemaString(
      SchemaDeclaration.make0(
        'String',
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
class SchemaStringLift{
  static public function validate(){
    return new stx.schema.validation.term.String();
  }
}