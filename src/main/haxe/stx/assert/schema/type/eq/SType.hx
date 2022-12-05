package stx.assert.schema.type.eq;

import stx.schema.SType as TSType;

class SType extends EqCls<TSType>{
  public function new(){}
  public function comply(thiz:TSType,that:TSType):Equaled{
    return switch([thiz.data,that.data]){
        case [STMono,STMono]                : AreEqual;
        case [STLazy(l),STLazy(r)]          : new stx.assert.schema.type.eq.LazyType().comply(l.pop(),r.pop());
        case [STNative(l),STNative(r)]      : new stx.assert.schema.type.eq.NativeType().comply(l.pop(),r.pop());
        case [STAnon(l),STAnon(r)]          : new stx.assert.schema.type.eq.AnonType().comply(l.pop(),r.pop());
        case [STRecord(l),STRecord(r)]      : new stx.assert.schema.core.eq.Identity().comply(l.identity,r.identity);
        case [STGeneric(l),STGeneric(r)]    : new stx.assert.schema.type.eq.GenericType().comply(l.pop(),r.pop());
        case [STUnion(l),STUnion(r)]        : new stx.assert.schema.type.eq.UnionType().comply(l.pop(),r.pop());
        case [STLink(l),STLink(r)]          : new stx.assert.schema.type.eq.LinkType().comply(l.pop(),r.pop());
        case [STEnum(l),STEnum(r)]          : new stx.assert.schema.type.eq.EnumType().comply(l.pop(),r.pop());
        case [l,r]                          : Eq.EnumValueIndex().comply(l,r);
    }
  }
}