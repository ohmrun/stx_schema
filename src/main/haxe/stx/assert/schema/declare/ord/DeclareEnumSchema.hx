package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareEnumSchema in TDeclareEnumSchema;

class DeclareEnumSchema extends OrdCls<TDeclareEnumSchema> {
  public function new(){}
  public function comply(lhs:TDeclareEnumSchema,rhs:TDeclareEnumSchema){
    var ord = new stx.assert.schema.core.ord.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
