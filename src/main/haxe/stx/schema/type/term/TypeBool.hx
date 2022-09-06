package stx.schema.type.term;

class TypeBool extends LeafType{
  static public var _(default,never) = TypeBoolLift;
  public function new(){
    final ident = Ident.make("Bool",["std"]);
    super(ident,__.g().ctype().Path(p -> p.fromIdent(ident)),PEmpty);
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
