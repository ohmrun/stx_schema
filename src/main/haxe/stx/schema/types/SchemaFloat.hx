package stx.schema.types;

abstract SchemaFloat(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaFloatLift;
  public function new() this = {
    name        : "Float",
    pack        : [],
    validation  : [ValidationFunc(_.validate)]
  }

  public function prj():SchemaDeclarationDef return this;
  
  @:to public function toSchemaDeclaration():SchemaDeclaration{
    return SchemaDeclaration.lift(this);
  } 
}
class SchemaFloatLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TInt       : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TFloat,x)));
    }
  }
}