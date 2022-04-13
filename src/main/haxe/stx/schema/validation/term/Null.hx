package stx.schema.validation.term;

class Null implements ValidationComplyApi extends ValidationComplyCls{
  public function comply(value:Dynamic,type:stx.schema.SType){
    return if(value == null){
      __.report();
    }else{
      switch(type.data){
        case STGeneric(def)    : def.pop().type.validation.lfold(value,type);
        default               : __.report(f -> f.of(E_Schema_WrongType(type)));
      }
    }
  }
}