package stx.schema.validation.term;

class Bool implements ValidationComplyApi extends ValidationComplyCls{
  public function comply(value:Dynamic,_:SType) {
    return switch(std.Type.typeof(value)){
      case TBool      : __.report();
      case x          : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TBool,x)));
    }
  }
}