package stx.assert.schema.ord;

import stx.schema.type.ScalarType as TScalarType;

class ScalarType extends OrdCls<TScalarType>{
  public function new(){}
  public function comply(thiz:TScalarType,that:TScalarType){
    var ord = new BaseType().comply(thiz,that);
    if(ord.is_not_less_than()){
      ord = new stx.assert.g.ord.GComplexType().comply(thiz.ctype,that.ctype);
    }
    return ord;
  }
}