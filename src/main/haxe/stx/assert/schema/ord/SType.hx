package stx.assert.schema.ord;

import stx.schema.SType as TSType;

class SType extends OrdCls<TSType>{
  public function new(){}
  public function comply(thiz:TSType,that:TSType):Ordered{
    return switch([thiz.data,that.data]){
        case [STMono,STMono]                : NotLessThan;
        case [STLazy(l),STLazy(r)]          : new stx.assert.schema.ord.LazyType().comply(l.pop(),r.pop());
        case [STScalar(l),STScalar(r)]      : new stx.assert.schema.ord.ScalarType().comply(l.pop(),r.pop());
        case [STAnon(l),STAnon(r)]          : new stx.assert.schema.ord.AnonType().comply(l.pop(),r.pop());
        case [STRecord(l),STRecord(r)]      : new stx.assert.schema.ord.RecordType().comply(l.pop(),r.pop());
        case [STGeneric(l),STGeneric(r)]    : new stx.assert.schema.ord.GenericType().comply(l.pop(),r.pop());
        case [STUnion(l),STUnion(r)]        : new stx.assert.schema.ord.UnionType().comply(l.pop(),r.pop());
        case [STLink(l),STLink(r)]          : new stx.assert.schema.ord.LinkType().comply(l.pop(),r.pop());
        case [STEnum(l),STEnum(r)]          : new stx.assert.schema.ord.EnumType().comply(l.pop(),r.pop());
        case [l,r]                          : Ord.EnumValueIndex().comply(l,r);
    }
  }
}