package stx.assert.schema.type.ord;

import stx.schema.type.RecordType as TRecordType;

class RecordType extends OrdCls<TRecordType>{
  public function new(){}
  public function comply(lhs:TRecordType,rhs:TRecordType){
    return new stx.assert.schema.type.ord.BaseType().comply(lhs,rhs);//TODO Double check this is complete 
  }
}