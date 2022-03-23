package stx.schema.core.type.term;

class TypeNull extends GenericTypeCls{
  static public var _(default,never) = TypeNullLift;
  static public function make(type){
    return new TypeNull(type);
  }
  public function new(type){
    super("Null",["std"],type);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationFunc(_.validate));
  }
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