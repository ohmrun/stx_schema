package stx.schema.term;

abstract SchemaNull(DeclareGenericSchemaDef) from DeclareGenericSchemaDef to DeclareGenericSchemaDef{
  static public var _(default,never) = SchemaNullLift;
  @:noUsing static public function make(ref){
    return new SchemaNull(
      DeclareGenericSchema.make(
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
  @:to public function toDeclareGenericSchema(){
    return DeclareGenericSchema.lift(this);
  }
}
class SchemaNullLift{
  static public function validate(){
    return new stx.schema.validation.term.Null();
  }
}