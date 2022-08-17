package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareSchema in TDeclareSchema;

class DeclareSchema extends EqCls<TDeclareSchema> {
  public function new(){}
  public function comply(lhs:TDeclareSchema,rhs:TDeclareSchema){
    var eq = new stx.assert.schema.eq.Validations().comply(lhs.validation,rhs.validation);
    if(eq.is_equal()){
      eq = new stx.assert.pml.eq.PExpr(Eq.Primitive()).comply(lhs.meta,rhs.meta);
    }
    return eq;
  }
}
