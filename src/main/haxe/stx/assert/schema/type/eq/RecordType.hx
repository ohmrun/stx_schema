package stx.assert.schema.type.eq;

import stx.schema.type.RecordType as TRecordType;

class RecordType extends EqCls<TRecordType>{
  public function new(){}
  public function comply(lhs:TRecordType,rhs:TRecordType){
    return new stx.assert.schema.type.eq.BaseType().comply(lhs,rhs);//TODO Double check this is complete 
  }
}