package stx.schema.core.type.term;

abstract TypeInt(DataTypeDef) from DataTypeDef to DataTypeDef{
  static public var _(default,never) = TypeIntLift;
  public function new() this = {
    name        : "Int",
    pack        : Cluster.pure("std"),
    validation  : Cluster.unit().snoc(ValidationFunc(_.validate))
  }

  public function prj():DataTypeDef return this;
  
  // @:to public function toSchemaDeclaration():SchemaDeclaration{
  //   return SchemaDeclaration.lift(this);
  // }
  // @:to public function toSchema():Schema{
  //   return Schema.fromSchemaDeclaration(this);
  // } 
  public function toType():Type{
    return TData(this);
  }
}
class TypeIntLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TInt       : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TInt,x)));
    }
  }
}