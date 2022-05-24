package stx.schema.declare.term;

abstract SchemaString(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  static public var _(default,never) = SchemaStringLift;
  @:noUsing static public function make(){
    return new SchemaString(
      SchemaScalar.make0(
        'String',['std'],
        PEmpty,
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
class SchemaStringLift{
  static public function validate(){
    return new stx.schema.validation.term.String();
  }
}