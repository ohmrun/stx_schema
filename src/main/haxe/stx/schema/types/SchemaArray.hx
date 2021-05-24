package stx.schema.types;

abstract SchemaArray(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaArrayLift;
  public function new(type:SchemaRef) this = {
    name        : "Array",
    pack        : [],
    type        : type,
    validation  : [ValidationFunc(_.validate)],
  }

  public function prj():SchemaGenericDeclarationDef return this;
  
  @:to public function toSchemaDeclaration():SchemaDeclaration{
    return SchemaDeclaration.lift(this);
  } 
}
class SchemaArrayLift{
  static public function validate(value,schema:Schema){
    return if(value == null){
      __.report();
    }else{
      switch(schema){
        case SchGeneric(def)  :
          var fn : Dynamic -> Report<SchemaFailure> = def.type.get().validation.lfold.bind(_,schema);
          var arr : Array<Dynamic>                  = value;
          return arr.lfold(
            (next:Dynamic,memo) => memo.merge(fn(next)),
            __.report()
          );
        default               : __.report(f -> f.of(E_Schema_WrongSchemaType(schema)));
      }
    }
  }
}