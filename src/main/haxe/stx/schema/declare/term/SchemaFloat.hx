package stx.schema.declare.term;

abstract SchemaFloat(DeclareSchemaDef) from DeclareSchemaDef to DeclareSchemaDef{
  static public var _(default,never) = SchemaFloatLift;
  @:noUsing static public function make(){
    return new SchemaFloat(
      DeclareSchema.make0(
        'Float',
        ['std'],
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareSchema(){
    return DeclareSchema.lift(this);
  }
}
class SchemaFloatLift{
  static public function validate(){
    return new stx.schema.validation.term.Float();
  }
}