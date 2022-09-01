package stx.schema.declare.term;

abstract SchemaDate(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  static public var _(default,never) = SchemaDateLift;
  @:noUsing static public function make(){
    return new SchemaDate(
      new DeclareScalarSchemaCls(
        Ident.make('Date',['std']),
        null,
        null
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
class SchemaDateLift{
  
}