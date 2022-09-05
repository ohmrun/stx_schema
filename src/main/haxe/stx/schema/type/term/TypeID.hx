package stx.schema.type.term;

class TypeID extends LeafType{
  static public var _(default,never) = TypeIDLift;
  public function new(register){
    final ident = Ident.make("ID",["stx","schema"]);
    super(register,ident,__.g().ctype().Path(p -> p.fromIdent(ident)),PEmpty);
  }
  // override public function get_validation(){
  //   return Cluster.pure(ValidationType(_.validate()));
  // }
}
class TypeIDLift{
  // static public function validate(){
  //   return new stx.schema.validation.term.String();
  // }
}
