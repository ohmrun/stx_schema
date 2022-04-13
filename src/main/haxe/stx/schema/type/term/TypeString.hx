package stx.schema.type.term;

class TypeString extends LeafType{
  static public var _(default,never) = TypeStringLift;
  public function new(){
    super("String",["std"]);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeStringLift{
  static public function validate(){
    return new stx.schema.validation.term.String();
  }
}
