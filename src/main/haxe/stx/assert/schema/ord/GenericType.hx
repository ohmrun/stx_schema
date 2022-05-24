package stx.assert.schema.ord;

import stx.schema.type.GenericType as TGenericType;

class GenericType extends OrdCls<TGenericType>{
  public function new(){}
  public function comply(lhs:TGenericType,rhs:TGenericType){
    return new stx.assert.schema.ord.BaseType().comply(lhs,rhs);//TODO Double check this is complete 
  }
}