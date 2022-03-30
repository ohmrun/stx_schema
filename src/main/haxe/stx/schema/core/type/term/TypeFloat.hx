package stx.schema.core.type.term;

class TypeFloat extends LeafType{
  static public var _(default,never) = TypeFloatLift;

  public function new(){
    super("Float",["std"]);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeFloatLift{
  static public function validate(){
    return new stx.schema.validation.term.Float();
  }
}