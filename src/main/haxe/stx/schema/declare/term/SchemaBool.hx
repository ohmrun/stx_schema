package stx.schema.declare.term;

abstract SchemaBool(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  static public var _(default,never) = SchemaBoolLift;
  @:noUsing static public function make(){
    return new SchemaBool(
      new DeclareScalarSchemaCls(
        Ident.make('Bool',['std']),
        null,
        ValidationType(_.validate())
      )
    );
  }
  @:to public function toDeclareSchema(){
    return DeclareScalarSchema.lift(this);
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