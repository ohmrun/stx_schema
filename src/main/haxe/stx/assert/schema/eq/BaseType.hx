package stx.assert.schema.eq;

import stx.schema.type.BaseType.BaseTypeApi as TBaseType;

class BaseType extends EqCls<TBaseType>{
  public function new(){}
  public function comply(thiz:TBaseType,that:TBaseType){
    var eq = new stx.assert.schema.eq.Identity().comply(thiz.identity,that.identity);
    if(eq.is_equal()){
      eq = new stx.assert.schema.eq.Validations().comply(thiz.validation,that.validation);
    }
    if(eq.is_equal()){
      eq = new stx.assert.pml.eq.PExpr(Eq.Primitive()).comply(thiz.meta,that.meta);
    }
    return eq;
  }
}