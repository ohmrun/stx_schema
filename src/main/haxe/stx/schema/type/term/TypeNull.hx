package stx.schema.type.term;

class TypeNull extends GenericTypeCls{
  static public var _(default,never) = TypeNullLift;
  @:noUsing static public function make(id,type){
    return new TypeNull(id,type);
  }
  public function new(id,type){
    super(id,Ident.make("Null",["std"]),type);
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
