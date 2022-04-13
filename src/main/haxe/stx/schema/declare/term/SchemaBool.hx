package stx.schema.declare.term;

abstract SchemaBool(DeclareSchemaDef) from DeclareSchemaDef to DeclareSchemaDef{
  static public var _(default,never) = SchemaBoolLift;
  @:noUsing static public function make(){
    return new SchemaBool(
      DeclareSchema.make0(
        'Bool',
        ['std'],
        ValidationType(_.validate())
      )
    );
  }
  @:to public function toDeclareSchema(){
    return DeclareSchema.lift(this);
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