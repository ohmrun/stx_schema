package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareEnumSchema in TDeclareEnumSchema;

class DeclareEnumSchema extends EqCls<TDeclareEnumSchema> {
  public function new(){}
  public function comply(lhs:TDeclareEnumSchema,rhs:TDeclareEnumSchema){
    var ord = new stx.assert.schema.core.eq.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
