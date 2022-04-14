package stx.schema.declare.term;

abstract SchemaString(DeclareSchemaApi) from DeclareSchemaApi to DeclareSchemaApi{
  static public var _(default,never) = SchemaStringLift;
  @:noUsing static public function make(){
    return new SchemaString(
      DeclareSchema.make0(
        'String',
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
class SchemaStringLift{
  static public function validate(){
    return new stx.schema.validation.term.String();
  }
}