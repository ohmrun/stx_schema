package stx.schema.declare.term;

@:forward abstract SchemaArray(DeclareGenericSchemaApi) from DeclareGenericSchemaApi to DeclareGenericSchemaApi{
  static public var _(default,never) = SchemaArrayLift;
  @:noUsing static public function make(ref:SchemaRef){
    return new SchemaArray(
      new DeclareGenericSchemaCls(
        Ident.make('Array',['std']),
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
  // public function resolve(state:TyperContext):Schema{  
  //   // final result =  SchGeneric(state.get(this.type.identity).fold(
  //   //   x  -> SchemaArray.make(x),
  //   //   () -> {
  //   //     final next = this.type.resolve(state); 
  //   //     return SchemaArray.make(next);
  //   //   }
  //   // ));
  //   // state.put(result);
  //   return throw UNIMPLEMENTED;
  // }
}
class SchemaArrayLift{
  static public function validate(){
    return new stx.schema.validation.term.Array();
  }
}
