package stx.schema.declare.term;

abstract SchemaInt(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  static public var _(default,never) = SchemaIntLift;
  @:noUsing static public function make(){
    return new SchemaInt(
      SchemaScalar.make0(
        'Int',['std'] ,
        Empty,
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareScalarSchema(){
    return DeclareScalarSchema.lift(this);
  }
}
class SchemaIntLift{
  static public function validate(){
    return new stx.schema.validation.term.Int();
  }
}