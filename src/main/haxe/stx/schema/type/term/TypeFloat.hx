package stx.schema.type.term;

class TypeFloat extends LeafType{
  static public var _(default,never) = TypeFloatLift;

  public function new(){
    final ident = Ident.make("Float",["std"]);
    super(ident,__.g().ctype().Path(p -> p.fromIdent(ident)),Empty);
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