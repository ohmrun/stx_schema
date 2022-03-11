package stx.schema.core.type.term;

abstract TypeArray(GenericTypeDef) from GenericTypeDef to GenericTypeDef{
  static public var _(default,never) = TypeArrayLift;
  static public function make(type:Type) return new TypeArray({
    name        : "Array",
    pack        : Cluster.pure("std"),
    type        : type,
    validation  : Cluster.lift([ValidationFunc(_.validate)]),
  });
  public function new(self:GenericTypeDef){
    this = self;
  }
  public function prj():GenericTypeDef return this;
  
  @:to public function toType(){
    return TGeneric(this);
  }
  // @:to public function toSchemaDeclaration():SchemaDeclaration{
  //   return SchemaDeclaration.lift(this);
  // } 
  // @:to public function toSchema():Schema{
  //   return Schema.fromSchemaGenericDeclaration(this);
  // }
}
class TypeArrayLift{
  static public function validate(value,type:Type){
    return if(value == null){
      __.report();
    }else{
      switch(type){
        case TGeneric(def)  :
          var fn : Dynamic -> Report<SchemaFailure>   = def.type.validation.lfold.bind(_,type);
          var arr : Cluster<Dynamic>                  = value;
          return arr.lfold(
            (next:Dynamic,memo:Report<SchemaFailure>) -> memo.concat(fn(next)),
            __.report()
          );
        default               : __.report(f -> f.of(E_Schema_WrongType(type)));
      }
    }
  }
}