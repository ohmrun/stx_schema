package stx.schema.type.term;

@:using(stx.schema.type.term.TypeArray.TypeArrayLift)
class TypeArray extends GenericTypeCls{
  static public var _(default,never) = TypeArrayLift;
  @:noUsing static public function make(type){
    return new TypeArray(type);
  }
  public function new(type:SType){
    super(Ident.make("Array",["std"]),type);
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