package stx.schema.declare.term;

abstract SchemaNull(DeclareGenericSchemaApi) from DeclareGenericSchemaApi to DeclareGenericSchemaApi{
  static public var _(default,never) = SchemaNullLift;
  @:noUsing static public function make(ref:SchemaRef){
    return new SchemaNull(
      new DeclareGenericSchemaCls(
        Ident.make('Null',['std']),
        ref
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
  
}