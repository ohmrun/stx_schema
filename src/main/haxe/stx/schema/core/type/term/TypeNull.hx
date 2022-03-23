package stx.schema.core.type.term;

abstract TypeNull(GenericType) from GenericType to GenericType{
  static public var _(default,never) = TypeNullLift;
  static public function make(type:Type) {
    final ident = Ident.fromObject({
      name        : "Null",
      pack        : ["std"],
    });
    return new TypeNull({
      name        : ident.name,
      pack        : ident.pack,
      toString    : () -> ident.toIdentifier().toString(),
      type        : type,
      validation  : Cluster.unit().snoc(ValidationFunc(_.validate))
    });
  }
  public function new(self){
    this = self;
  }
  public function prj():GenericType return this;
  
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
class TypeNullLift{
  static public function validate(value,type:Type){
    return if(value == null){
      __.report();
    }else{
      switch(type){
        case TGeneric(def)    : def.pop().type.validation.lfold(value,type);
        default               : __.report(f -> f.of(E_Schema_WrongType(type)));
      }
    }
  }
}