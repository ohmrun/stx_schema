package stx.schema.core.type.term;

abstract TypeFloat(DataTypeDef) from DataTypeDef to DataTypeDef{
  static public var _(default,never) = TypeFloatLift;
  public function new() {
    final ident = Ident.fromObject({
      name        : "Float",
      pack        : ["std"],
    });
    this = {
      name        : ident.name,
      pack        : ident.pack,
      toString    : () -> ident.toIdentifier().toString(),
      validation  : [ValidationFunc(_.validate)]
    }
  }

  public function prj():DataTypeDef return this;
  
  // @:to public function toSchemaDeclaration():SchemaDeclaration{
  //   return SchemaDeclaration.lift(this);
  // }  
  @:to public function toType():Type{
    return TData(Ref.pure(this));
  }
}
class TypeFloatLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TFloat     : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TFloat,x)));
    }
  }
}