package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareRecordSchema in TDeclareRecordSchema;

class DeclareRecordSchema extends EqCls<TDeclareRecordSchema> {
  public function new(){}
  public function comply(lhs:TDeclareRecordSchema,rhs:TDeclareRecordSchema){
    var eq = new stx.assert.schema.core.eq.Identity().comply(lhs.identity,rhs.identity);
    if(eq.is_equal()){
      eq = new stx.assert.schema.declare.eq.Procurements().comply(lhs.fields,rhs.fields);
    }
    return eq;
  }
}
