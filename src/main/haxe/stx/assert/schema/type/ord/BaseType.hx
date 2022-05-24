package stx.assert.schema.type.ord;

import stx.schema.type.BaseType.BaseTypeApi as TBaseType;

class BaseType extends OrdCls<TBaseType>{
  public function new(){}
  public function comply(thiz:TBaseType,that:TBaseType){
    var ord = new stx.assert.schema.core.ord.Identity().comply(thiz.identity,that.identity);
    if(ord.is_not_less_than()){
      ord = new stx.assert.schema.ord.Validations().comply(thiz.validation,that.validation);
    }
    if(ord.is_not_less_than()){
      ord = new stx.assert.pml.ord.PExpr(Ord.Primitive()).comply(thiz.meta,that.meta);
    }
    return ord;
  }
}