package stx.assert.schema.type.eq;

import stx.schema.type.UnionType as TUnionType;

class UnionType extends EqCls<TUnionType>{
  public function new(){}
  public function comply(lhs:TUnionType,rhs:TUnionType){
    return new stx.assert.schema.type.eq.BaseType().comply(lhs,rhs);
  }
}