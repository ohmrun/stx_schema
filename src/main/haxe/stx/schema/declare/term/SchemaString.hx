package stx.schema.declare.term;

abstract SchemaString(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  static public var _(default,never) = SchemaStringLift;
  @:noUsing static public function make(){
    return new SchemaString(
      new DeclareScalarSchemaCls(
        Ident.make('String',['std']),
        null,
        ValidationType(_.validate()),
        PEmpty
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