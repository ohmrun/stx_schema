package stx.schema.type.term;

class TypeString extends LeafType{
  static public var _(default,never) = TypeStringLift;
  public function new(id){
    final ident = Ident.make("String",["std"]);
    super(id,ident,__.g().ctype().Path(p -> p.fromIdent(ident)),PEmpty);
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
