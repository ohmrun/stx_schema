package stx.assert.schema.type.eq;

import stx.schema.type.GenericType as TGenericType;

class GenericType extends EqCls<TGenericType>{
  public function new(){}
  public function comply(lhs:TGenericType,rhs:TGenericType){
    return new stx.assert.schema.type.eq.BaseType().comply(lhs,rhs);//TODO Double check this is complete 
  }
}