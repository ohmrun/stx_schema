package stx.schema.types;

abstract SchemaNull(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaNullLift;
  public function new(type:SchemaRef) this = {
    name        : "Null",
    pack        : [],
    type        : type,
    validation  : [ValidationFunc(_.validate)],
  }

  public function prj():SchemaGenericDeclarationDef return this;
  
  @:to public function toSchemaDeclaration():SchemaDeclaration{
    return SchemaDeclaration.lift(this);
  } 
}
class SchemaNullLift{
  static public function validate(value,schema:Schema){
    return if(value == null){
      __.report();
    }else{
      switch(schema){
        case SchGeneric(def)  : def.type.get().validation.lfold(value,schema);
        default               : __.report(f -> f.of(E_Schema_WrongSchemaType(schema)));
      }
    }
  }
}