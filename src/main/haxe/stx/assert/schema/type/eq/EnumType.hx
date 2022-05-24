package stx.assert.schema.type.eq;

import stx.schema.type.EnumType as TEnumType;

class EnumType extends EqCls<TEnumType>{
  public function new(){}
  public function comply(lhs:TEnumType,rhs:TEnumType){
    return Eq.Ident().comply(lhs.ident,rhs.ident);
  }
}