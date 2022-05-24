package stx.schema.declare.term;

abstract SchemaFloat(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  static public var _(default,never) = SchemaFloatLift;
  @:noUsing static public function make(){
    return new SchemaFloat(
      SchemaScalar.make0(
        'Float',['std'],
        PEmpty,
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareSchema(){
    return DeclareScalarSchema.lift(this);
  }
}
class SchemaFloatLift{
  static public function validate(){
    return new stx.schema.validation.term.Float();
  }
}