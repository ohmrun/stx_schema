package stx.schema.type.term;

@:using(stx.schema.type.term.TypeArray.TypeArrayLift)
class TypeArray extends GenericTypeCls{
  static public var _(default,never) = TypeArrayLift;
  @:noUsing static public function make(id,type){
    return new TypeArray(id,type);
  }
  public function new(id,type:SType){
    super(id,Ident.make("Array",["std"]),type);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeArrayLift{
  static public function validate(){
    return new stx.schema.validation.term.Array();
  }
}