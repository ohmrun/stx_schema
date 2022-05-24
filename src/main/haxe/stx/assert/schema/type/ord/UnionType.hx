package stx.assert.schema.type.ord;

import stx.schema.type.UnionType as TUnionType;

class UnionType extends OrdCls<TUnionType>{
  public function new(){}
  public function comply(lhs:TUnionType,rhs:TUnionType){
    return new stx.assert.schema.type.ord.BaseType().comply(lhs,rhs);
  }
}