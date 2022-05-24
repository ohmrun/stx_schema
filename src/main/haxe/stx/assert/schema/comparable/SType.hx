package stx.assert.schema.comparable;

import stx.schema.SType as TSType;

class SType implements ComparableApi<TSType>{
  public function new(){}
  public function lt(){
    return new stx.assert.schema.ord.SType();
  }
  public function eq(){
    return throw UNIMPLEMENTED;
  }
}