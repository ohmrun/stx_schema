package stx.schema.types;

abstract SchemaInt(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaIntLift;
  public function new() this = {
    name        : "Int",
    pack        : Cluster.unit(),
    validation  : Cluster.unit().snoc(ValidationFunc(_.validate))
  }

  public function prj():SchemaDeclarationDef return this;
  
  @:to public function toSchemaDeclaration():SchemaDeclaration{
    return SchemaDeclaration.lift(this);
  }
  @:to public function toSchema():Schema{
    return Schema.fromSchemaDeclaration(this);
  } 
}
class SchemaIntLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TInt       : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TInt,x)));
    }
  }
}