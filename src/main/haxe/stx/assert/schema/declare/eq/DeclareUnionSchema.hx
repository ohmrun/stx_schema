package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareUnionSchema in TDeclareUnionSchema;

class DeclareUnionSchema extends EqCls<TDeclareUnionSchema> {
  public function new(){}
  public function comply(lhs:TDeclareUnionSchema,rhs:TDeclareUnionSchema){
    var ord = new stx.assert.schema.core.eq.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
