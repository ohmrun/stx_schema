package stx.schema.validation.term;

class Int implements ValidationComplyApi extends ValidationComplyCls{
  public function comply(value:Dynamic,_:SType){
    return switch(std.Type.typeof(value)){
      case TInt       : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TInt,x)));
    }
  }
}