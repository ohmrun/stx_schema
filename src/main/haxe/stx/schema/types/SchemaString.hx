package stx.schema.types;

abstract SchemaString(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaStringLift;
  public function new() this = {
    name        : "String",
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
  @:to public function toSchemaRef():SchemaRef{
    return SchemaRef.fromSchemaSum(Schema.fromSchemaDeclaration(this));
  }
}
class SchemaStringLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TClass(String)       : __.report();
      case x                    : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TClass(String),x)));
    }
  }
}