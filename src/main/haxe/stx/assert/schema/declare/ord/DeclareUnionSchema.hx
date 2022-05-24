package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareUnionSchema in TDeclareUnionSchema;

class DeclareUnionSchema extends OrdCls<TDeclareUnionSchema> {
  public function new(){}
  public function comply(lhs:TDeclareUnionSchema,rhs:TDeclareUnionSchema){
    var ord = new stx.assert.schema.core.ord.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
