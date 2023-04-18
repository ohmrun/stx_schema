package stx.assert.schema.eq;

import stx.schema.Schema as TSchema;

class Schema extends EqCls<TSchema>{
  public function new(){}
  public function comply(lhs:TSchema,rhs:TSchema){
    return switch([lhs,rhs]){
      case [SchNative(l),SchNative(r)]    : new stx.assert.schema.declare.eq.DeclareNativeSchema().comply(l,r);
      case [SchRecord(l),SchRecord(r)]    : new stx.assert.schema.declare.eq.DeclareRecordSchema().comply(l,r);
      case [SchEnum(l),SchEnum(r)]        : new stx.assert.schema.declare.eq.DeclareEnumSchema().comply(l,r);
      case [SchGeneric(l),SchGeneric(r)]  : new stx.assert.schema.declare.eq.DeclareGenericSchema().comply(l,r);
      case [SchUnion(l),SchUnion(r)]      : new stx.assert.schema.declare.eq.DeclareUnionSchema().comply(l,r);
      case [l,r]                          : Eq.EnumValueIndex().comply(l,r);
    }
  }
}
