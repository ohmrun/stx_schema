package stx.schema.types;

abstract SchemaArray(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaArrayLift;
  static public function make(type:SchemaRef) return new SchemaArray({
    name        : "Array",
    pack        : Cluster.unit(),
    type        : type,
    validation  : Cluster.lift([ValidationFunc(_.validate)]),
  });
  public function new(self:SchemaGenericDeclarationDef){
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
class SchemaArrayLift{
  static public function validate(value,schema:Schema){
    return if(value == null){
      __.report();
    }else{
      switch(schema){
        case SchGeneric(def)  :
          var fn : Dynamic -> Report<SchemaFailure>   = def.type.get().validation.lfold.bind(_,schema);
          var arr : Cluster<Dynamic>                  = value;
          return arr.lfold(
            (next:Dynamic,memo:Report<SchemaFailure>) -> memo.merge(fn(next)),
            __.report()
          );
        default               : __.report(f -> f.of(E_Schema_WrongSchemaType(schema)));
      }
    }
  }
}