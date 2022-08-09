package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareRecordSchema in TDeclareRecordSchema;

class DeclareRecordSchema extends OrdCls<TDeclareRecordSchema> {
  public function new(){}
  public function comply(lhs:TDeclareRecordSchema,rhs:TDeclareRecordSchema){
    var ord = new stx.assert.schema.core.ord.Identity().comply(lhs.identity,rhs.identity);
    if(ord.is_not_less_than()){
      ord = new stx.assert.schema.declare.ord.Procurements().comply(lhs.fields,rhs.fields);
    }
    return ord;
  }
}
