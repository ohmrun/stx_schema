package stx.schema.type.term;

class TypeNull extends GenericTypeCls{
  static public var _(default,never) = TypeNullLift;
  @:noUsing static public function make(register,type){
    return new TypeNull(register,type);
  }
  public function new(register,type){
    super(register,Ident.make("Null",["std"]),type);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeNullLift{
  static public function validate(){
    return new stx.schema.validation.term.Null();
  }
}
