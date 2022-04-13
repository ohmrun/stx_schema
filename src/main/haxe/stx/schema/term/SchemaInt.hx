package stx.schema.term;

abstract SchemaInt(DeclareSchemaDef) from DeclareSchemaDef to DeclareSchemaDef{
  static public var _(default,never) = SchemaIntLift;
  @:noUsing static public function make(){
    return new SchemaInt(
      DeclareSchema.make0(
        'Int',
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
class SchemaIntLift{
  static public function validate(){
    return new stx.schema.validation.term.Int();
  }
}