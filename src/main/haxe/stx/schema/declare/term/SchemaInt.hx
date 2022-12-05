package stx.schema.declare.term;

abstract SchemaInt(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  static public var _(default,never) = SchemaIntLift;
  @:noUsing static public function make(){
    return new SchemaInt(
      new DeclareNativeSchemaCls(
        Ident.make('Int',['std']),
        null,
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareNativeSchema(){
    return DeclareNativeSchema.lift(this);
  }
}
class SchemaIntLift{
  static public function validate(){
    return new stx.schema.validation.term.Int();
  }
}