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
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeNullLift{
  static public function validate(){
    return new stx.schema.validation.term.Null();
  }
}
