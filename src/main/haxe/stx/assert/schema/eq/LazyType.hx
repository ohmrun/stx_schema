package stx.assert.schema.eq;

import stx.schema.type.LazyType in TLazyType;

class LazyType extends EqCls<TLazyType>{
  public function new(){}
  public function comply(lhs:TLazyType,rhs:TLazyType){
    return new stx.assert.schema.eq.Identity().comply(lhs.lookup,rhs.lookup);
  }
}