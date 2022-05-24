package stx.assert.schema.type.ord;

import stx.schema.type.EnumType as TEnumType;

class EnumType extends OrdCls<TEnumType>{
  public function new(){}
  public function comply(lhs:TEnumType,rhs:TEnumType){
    return Ord.Ident().comply(lhs.ident,rhs.ident);
  }
}