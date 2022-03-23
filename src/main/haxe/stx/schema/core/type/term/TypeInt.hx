package stx.schema.core.type.term;

class TypeInt extends LeafType{
  static public var _(default,never) = TypeIntLift;
  public function new(){
    super("Int",["std"]);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationFunc(_.validate));
  }
}
class TypeIntLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TInt       : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TInt,x)));
    }
  }
}