package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareSchema in TDeclareSchema;

class DeclareSchema extends OrdCls<TDeclareSchema> {
  public function new(){}
  public function comply(lhs:TDeclareSchema,rhs:TDeclareSchema){
    var ord = new stx.assert.schema.core.ord.Identity().comply(lhs.identity,rhs.identity);
    if(ord.is_not_less_than()){
      ord = new stx.assert.pml.ord.PExpr(Ord.Primitive()).comply(lhs.meta,rhs.meta);
    }
    return ord;
  }
}
