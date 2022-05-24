package stx.assert.schema.ord;

import stx.schema.Schema as TSchema;

class Schema extends OrdCls<TSchema>{
  public function new(){}
  public function comply(lhs:TSchema,rhs:TSchema){
    return switch([lhs,rhs]){
      case [SchLazy(l),SchLazy(r)]        : comply(l(),r());
      case [SchScalar(l),SchScalar(r)]    : new stx.assert.schema.declare.ord.DeclareScalarSchema().comply(l,r);
      case [SchRecord(l),SchRecord(r)]    : new stx.assert.schema.declare.ord.DeclareRecordSchema().comply(l,r);
      case [SchEnum(l),SchEnum(r)]        : new stx.assert.schema.declare.ord.DeclareEnumSchema().comply(l,r);
      case [SchGeneric(l),SchGeneric(r)]  : new stx.assert.schema.declare.ord.DeclareGenericSchema().comply(l,r);
      case [SchUnion(l),SchUnion(r)]      : new stx.assert.schema.declare.ord.DeclareUnionSchema().comply(l,r);
      case [l,r]                          : Ord.EnumValueIndex().comply(l,r);
    }
  }
}
