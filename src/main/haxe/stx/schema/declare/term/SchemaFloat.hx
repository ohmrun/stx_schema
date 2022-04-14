package stx.schema.declare.term;

abstract SchemaFloat(DeclareSchemaApi) from DeclareSchemaApi to DeclareSchemaApi{
  static public var _(default,never) = SchemaFloatLift;
  @:noUsing static public function make(){
    return new SchemaFloat(
      DeclareSchema.make0(
        'Float',
        ['std'],
        Empty,
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