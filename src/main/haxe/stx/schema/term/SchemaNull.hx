package stx.schema.term;

abstract SchemaNull(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaNullLift;
  @:noUsing static public function make(ref){
    return new SchemaNull(
      SchemaGenericDeclaration.make(
        'Null',
        ['std'],
        ref,
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toSchemaGenericDeclaration(){
    return SchemaGenericDeclaration.lift(this);
  }
}
class SchemaNullLift{
  static public function validate(){
    return new stx.schema.validation.term.Null();
  }
}