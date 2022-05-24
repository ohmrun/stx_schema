package stx.assert.schema.type.eq;

import stx.schema.type.ScalarType as TScalarType;

class ScalarType extends EqCls<TScalarType>{
  public function new(){}
  public function comply(thiz:TScalarType,that:TScalarType){
    var eq = new stx.assert.schema.type.eq.BaseType().comply(thiz,that);
    if(eq.is_equal()){
      eq = Eq.Ident().comply(thiz.ident,that.ident);
    }
    if(eq.is_equal()){
      eq = new stx.assert.g.eq.GComplexType().comply(thiz.ctype,that.ctype);
    }
    return eq;
  }
}