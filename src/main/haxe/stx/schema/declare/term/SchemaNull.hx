package stx.schema.declare.term;

abstract SchemaNull(DeclareGenericSchemaApi) from DeclareGenericSchemaApi to DeclareGenericSchemaApi{
  static public var _(default,never) = SchemaNullLift;
  @:noUsing static public function make(ref){
    return new SchemaNull(
      new DeclareGenericSchemaCls(
        Ident.make('Null',['std']),
        ref,
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareGenericSchema(){
    return DeclareGenericSchema.lift(this);
  }
}
class SchemaNullLift{
  static public function validate(){
    return new stx.schema.validation.term.Null();
  }
}