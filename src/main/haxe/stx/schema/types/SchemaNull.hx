package stx.schema.types;

abstract SchemaNull(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaNullLift;
  static public function make(type:SchemaRef) return new SchemaNull({
    name        : "Null",
    pack        : Cluster.unit(),
    type        : type,
    validation  : Cluster.unit().snoc(ValidationFunc(_.validate))
  });
  public function new(self){
    this = self;
  }
  public function prj():SchemaGenericDeclarationDef return this;
  
  @:to public function toSchemaDeclaration():SchemaDeclaration{
    return SchemaDeclaration.lift(this);
  } 
  @:to public function toSchema():Schema{
    return Schema.fromSchemaGenericDeclaration(this);
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