package stx.schema.core.type.term;

class TypeArray extends GenericTypeCls{
  static public var _(default,never) = TypeArrayLift;
  static public function make(type){
    return new TypeArray(type);
  }
  public function new(type:Type){
    super("Array",["std"],type);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeArrayLift{
  static public function validate(){
    return new stx.schema.validation.term.Array();
  }
}