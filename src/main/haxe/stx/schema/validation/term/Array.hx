package stx.schema.validation.term;

class Array implements ValidationComplyApi extends ValidationComplyCls{
  public function comply(value:Dynamic,type:SType){
    return if(value == null){
      __.report();
    }else{
      switch(type.data){
        case STGeneric(def)  :
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