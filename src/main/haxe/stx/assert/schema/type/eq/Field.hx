package stx.assert.schema.type.eq;

import stx.schema.core.Field in TField;

class Field extends EqCls<TField>{
  public function new(){}
  public function comply(lhs:TField,rhs:TField){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_equal()){
      eq = new stx.assert.schema.type.eq.SType().comply(lhs.type,rhs.type);
    }
    return eq;
  }
}