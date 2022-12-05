package stx.schema.declare.term;

abstract SchemaBool(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  static public var _(default,never) = SchemaBoolLift;
  @:noUsing static public function make(){
    return new SchemaBool(
      new DeclareNativeSchemaCls(
        Ident.make('Bool',['std']),
        null,
        ValidationType(_.validate())
      )
    );
  }
  @:to public function toDeclareSchema(){
    return DeclareNativeSchema.lift(this);
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