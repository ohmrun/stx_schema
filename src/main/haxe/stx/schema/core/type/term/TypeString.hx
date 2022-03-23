package stx.schema.core.type.term;

class TypeString extends LeafType{
  static public var _(default,never) = TypeStringLift;
  public function new(){
    super("String",["std"]);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationFunc(_.validate));
  }
}
class TypeStringLift{
  static public function validate(value,_){
    return switch(std.Type.typeof(value)){
      case TClass(String)       : __.report();
      case x                    : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TClass(String),x)));
    }
  }
}