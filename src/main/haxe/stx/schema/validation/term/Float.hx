package stx.schema.validation.term;

class Float implements ValidationComplyApi extends ValidationComplyCls{
  public function comply(value:Dynamic,_:SType){
    return switch(std.Type.typeof(value)){
      case TFloat     : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TFloat,x)));
    }
  }
}