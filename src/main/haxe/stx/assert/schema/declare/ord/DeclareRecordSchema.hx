package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareRecordSchema in TDeclareRecordSchema;

class DeclareRecordSchema extends OrdCls<TDeclareRecordSchema> {
  public function new(){}
  public function comply(lhs:TDeclareRecordSchema,rhs:TDeclareRecordSchema){
    var ord = new stx.assert.schema.core.ord.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
