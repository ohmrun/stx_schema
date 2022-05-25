package stx.assert.schema.core.ord;

import stx.schema.core.Field in TField;

class Field extends OrdCls<TField>{
  public function new(){}
  public function comply(lhs:TField,rhs:TField){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = new stx.assert.schema.type.ord.SType().comply(lhs.type,rhs.type);
    }
    return ord;
  }
}