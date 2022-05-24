package stx.assert.schema.ord;

import stx.schema.type.LazyType in TLazyType;

class LazyType extends OrdCls<TLazyType>{
  public function new(){}
  public function comply(lhs:TLazyType,rhs:TLazyType){
    return new stx.assert.schema.ord.Identity().comply(lhs.lookup,rhs.lookup);
  }
}