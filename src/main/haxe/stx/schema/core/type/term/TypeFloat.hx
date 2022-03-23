package stx.schema.core.type.term;

class TypeFloat extends LeafType{
  static public var _(default,never) = TypeFloatLift;

  public function new(){
    super("Float",["std"]);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationFunc(_.validate));
  }
}
class TypeFloatLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TFloat     : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TFloat,x)));
    }
  }
}