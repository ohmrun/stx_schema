package stx.schema.type.term;

@:using(stx.schema.type.term.TypeZero.TypeZeroLift)
class TypeZero extends GenericTypeCls{
  static public var _(default,never) = TypeZeroLift;
  @:noUsing static public function make(type){
    return new TypeZero(type);
  }
  final data : GExpr;
  public function new(type:SType,data){
    super("Zero",["std"],type);
    this.data = data;
  }
  override public function get_validation(){
    return Cluster.pure(ValidationType(_.validate()));
  }
}
class TypeZeroLift{
  static public function validate(){
    return new stx.schema.validation.term.Zero();
  }
}