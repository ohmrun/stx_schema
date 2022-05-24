package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareSchema in TDeclareSchema;

class DeclareSchema extends EqCls<TDeclareSchema> {
  public function new(){}
  public function comply(lhs:TDeclareSchema,rhs:TDeclareSchema){
    var ord = new stx.assert.schema.core.eq.Identity().comply(lhs.identity,rhs.identity);
    if(ord.is_equal()){
      ord = new stx.assert.pml.eq.PExpr(Eq.Primitive()).comply(lhs.meta,rhs.meta);
    }
    return ord;
  }
}
