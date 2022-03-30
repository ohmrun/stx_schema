package stx.schema.term;

abstract SchemaArray(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaArrayLift;
  static public function make(ref:SchemaRef){
    return new SchemaArray(
      SchemaGenericDeclaration.make(
        'Array',
        ['std'],
        ref,
        ValidationType(_.validate())
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toSchemaGenericDeclaration(){
    return SchemaGenericDeclaration.lift(this);
  }
  public function resolve(state:Schemata):Schema{  
    final result =  SchGeneric(state.get(this.type.identity()).fold(
      x  -> SchemaArray.make(x),
      () -> {
        final next = this.type.resolve(state); 
        return SchemaArray.make(next);
      }
    ));
    state.put(result);
    return result;
  }
}
class SchemaArrayLift{
  static public function validate(){
    return new stx.schema.validation.term.Array();
  }
}
