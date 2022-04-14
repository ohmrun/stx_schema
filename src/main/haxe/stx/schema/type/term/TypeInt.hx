package stx.schema.type.term;

class TypeInt extends LeafType{
  static public var _(default,never) = TypeIntLift;
  public function new(){
    super(Ident.make("Int",["std"]));
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeIntLift{
  static public function validate(){
    return new stx.schema.validation.term.Int();
  }
}