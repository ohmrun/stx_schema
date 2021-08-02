package stx.schema.types;

abstract SchemaBool(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaBoolLift;
  public function new() this = {
    name        : "Bool",
    pack        : Cluster.unit(),
    validation  : Cluster.lift([ValidationFunc(_.validate)])
  }
  public function prj():SchemaDeclarationDef return this;

  @:to public function toSchemaDeclaration():SchemaDeclaration{
    return SchemaDeclaration.lift(this);
  } 
}
class SchemaBoolLift{
  static public function validate(value,_) {
    return switch(std.Type.typeof(value)){
      case TBool      : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TBool,x)));
    }
  }
}