package stx.assert.schema.type.ord;

import stx.schema.type.NativeType as TNativeType;

class NativeType extends OrdCls<TNativeType>{
  public function new(){}
  public function comply(thiz:TNativeType,that:TNativeType){
    var ord = new stx.assert.schema.type.ord.BaseType().comply(thiz,that);
    if(ord.is_not_less_than()){
      ord = Ord.Ident().comply(thiz.ident,that.ident);
    }
    if(ord.is_not_less_than()){
      ord = new stx.assert.g.ord.GComplexType().comply(thiz.ctype,that.ctype);
    }
    return ord;
  }
}