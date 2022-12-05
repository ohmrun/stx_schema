package stx.schema.declare.term;

abstract SchemaFloat(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  static public var _(default,never) = SchemaFloatLift;
  @:noUsing static public function make(){
    return new SchemaFloat(
      new DeclareNativeSchemaCls(
        Ident.make('Float',['std']),
        null,
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareSchema(){
    return DeclareNativeSchema.lift(this);
  }
}
class SchemaFloatLift{
  static public function validate(){
    return new stx.schema.validation.term.Float();
  }
}