package stx.schema.type.term;

class TypeInt extends LeafType{
  static public var _(default,never) = TypeIntLift;
  public function new(){
    final ident = Ident.make("Int",["std"]);
    super(ident,__.g().ctype().Path(p -> p.fromIdent(ident)),Empty);
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