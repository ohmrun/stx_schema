package stx.assert.schema.ord;

import stx.schema.type.UnionType as TUnionType;

class UnionType extends OrdCls<TUnionType>{
  public function new(){}
  public function comply(lhs:TUnionType,rhs:TUnionType){
    return new stx.assert.schema.ord.BaseType().comply(lhs,rhs);
  }
}