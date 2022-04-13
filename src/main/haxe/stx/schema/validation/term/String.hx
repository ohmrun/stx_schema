package stx.schema.validation.term;

class String implements ComplyApi<Dynamic,SType,Report<SchemaFailure>> extends ValidationComplyCls{
  public function comply(value:Dynamic,value:SType){
    return switch(std.Type.typeof(value)){
      case TClass(String)       : __.report();
      case x                    : __.report(f -> f.of(E_Schema_HaxeTypeError(ValueType.TClass(String),x)));
    }
  }
}