package stx.schema.core.type.term;

class TypeBool extends LeafType{
  static public var _(default,never) = TypeBoolLift;
  public function new(){
    super("Bool",["std"]);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationFunc(_.validate));
  }
}
class TypeBoolLift{
  static public function validate(value,_) {
    return switch(std.Type.typeof(value)){
      case TBool      : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TBool,x)));
    }
  }
}