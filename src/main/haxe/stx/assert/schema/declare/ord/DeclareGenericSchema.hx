package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareGenericSchema in TDeclareGenericSchema;

class DeclareGenericSchema extends OrdCls<TDeclareGenericSchema> {
  public function new(){}
  public function comply(lhs:TDeclareGenericSchema,rhs:TDeclareGenericSchema){
    var ord = new stx.assert.schema.core.ord.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
