package stx.schema.core.type.term;

class TypeArray extends GenericTypeCls{
  static public var _(default,never) = TypeArrayLift;
  static public function make(type){
    return new TypeArray(type);
  }
  public function new(type:Type){
    super("Array",["std"],type);
  }
  override public function get_validation(){
    return Cluster.pure(ValidationFunc(_.validate));
  }
}
class TypeArrayLift{
  static public function validate(value,type:Type){
    return if(value == null){
      __.report();
    }else{
      switch(type){
        case TGeneric(def)  :
          var fn : Dynamic -> Report<SchemaFailure>   = def.pop().type.validation.lfold.bind(_,type);
          var arr : Cluster<Dynamic>                  = value;
          return arr.lfold(
            (next:Dynamic,memo:Report<SchemaFailure>) -> memo.concat(fn(next)),
            __.report()
          );
        default               : __.report(f -> f.of(E_Schema_WrongType(type)));
      }
    }
  }
}