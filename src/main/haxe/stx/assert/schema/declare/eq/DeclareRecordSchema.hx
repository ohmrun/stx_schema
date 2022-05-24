package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareRecordSchema in TDeclareRecordSchema;

class DeclareRecordSchema extends EqCls<TDeclareRecordSchema> {
  public function new(){}
  public function comply(lhs:TDeclareRecordSchema,rhs:TDeclareRecordSchema){
    var ord = new stx.assert.schema.core.eq.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
