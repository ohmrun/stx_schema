package stx.assert.schema.type.comparable;

import stx.schema.SType as TSType;

class SType extends ComparableCls<TSType>{
  public function new(){}
  public function lt(){
    return new stx.assert.schema.type.ord.SType();
  }
  public function eq(){
    return new stx.assert.schema.type.eq.SType();
  }
}