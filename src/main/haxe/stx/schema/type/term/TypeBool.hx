package stx.schema.type.term;

class TypeBool extends LeafType{
  static public var _(default,never) = TypeBoolLift;
  public function new(){
    super("Bool",["std"]);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeBoolLift{
  static public function validate(){
    return new stx.schema.validation.term.Bool();
  }
}
