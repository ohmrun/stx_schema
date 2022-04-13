package stx.schema.type.term;

class TypeID extends LeafType{
  static public var _(default,never) = TypeIDLift;
  public function new(){
    super("ID",["stx","schema"]);
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
