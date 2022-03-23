package stx.schema.core.type.term;

abstract TypeString(DataTypeDef) from DataTypeDef to DataTypeDef {
  static public var _(default,never) = TypeStringLift;
  public function new() {
    final ident = Ident.fromObject({
      name        : "String",
      pack        : ["std"],
    });
    this = {
      name        : ident.name,
      pack        : ident.pack,
      toString    : () -> ident.toIdentifier().toString(),
      validation  : Cluster.unit().snoc(ValidationFunc(_.validate))
    }
  }

  public function prj():DataTypeDef return this;
  
  // @:to public function toSchemaDeclaration():SchemaDeclaration{
  //   return SchemaDeclaration.lift(this);
  // } 
  // @:to public function toSchema():Schema{
  //   return Schema.fromSchemaDeclaration(this);
  // }
  // @:to public function toSchemaRef():SchemaRef{
  //   return SchemaRef.fromSchemaSum(Schema.fromSchemaDeclaration(this));
  // }
  public function toType():Type{
    return TData(this);
  }
}
class TypeStringLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TClass(String)       : __.report();
      case x                    : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TClass(String),x)));
    }
  }
}