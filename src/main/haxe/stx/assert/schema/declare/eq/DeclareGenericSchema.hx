package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareGenericSchema in TDeclareGenericSchema;

class DeclareGenericSchema extends EqCls<TDeclareGenericSchema> {
  public function new(){}
  public function comply(lhs:TDeclareGenericSchema,rhs:TDeclareGenericSchema){
    var ord = new stx.assert.schema.core.eq.Identity().comply(lhs.identity,rhs.identity);
    return ord;
  }
}
