package stx.schema.term;

abstract SchemaBool(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaBoolLift;
  @:noUsing static public function make(){
    return new SchemaBool(
      SchemaDeclaration.make0(
        'Bool',
        ['std'],
        ValidationType(_.validate())
      )
    );
  }
  @:to public function toSchemaDeclaration(){
    return SchemaDeclaration.lift(this);
  }
  private function new(self){
    this = self;
  }
}
class SchemaBoolLift{
  static public function validate(){
    return new stx.schema.validation.term.Bool();
  }
}