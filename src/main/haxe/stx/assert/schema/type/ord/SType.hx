package stx.assert.schema.type.ord;

import stx.schema.SType as TSType;

class SType extends OrdCls<TSType>{
  public function new(){}
  public function comply(thiz:TSType,that:TSType):Ordered{
    return switch([thiz.data,that.data]){
        case [STMono,STMono]                : NotLessThan;
        case [STLazy(l),STLazy(r)]          : new stx.assert.schema.type.ord.LazyType().comply(l.pop(),r.pop());
        case [STNative(l),STNative(r)]      : new stx.assert.schema.type.ord.NativeType().comply(l.pop(),r.pop());
        case [STAnon(l),STAnon(r)]          : new stx.assert.schema.type.ord.AnonType().comply(l.pop(),r.pop());
        case [STRecord(l),STRecord(r)]      : 
          new stx.assert.schema.core.ord.Identity().comply(l.identity,r.identity);
          //new stx.assert.schema.type.ord.RecordType().comply(l.pop(),r.pop());
        case [STGeneric(l),STGeneric(r)]    : new stx.assert.schema.type.ord.GenericType().comply(l.pop(),r.pop());
        case [STUnion(l),STUnion(r)]        : new stx.assert.schema.type.ord.UnionType().comply(l.pop(),r.pop());
        case [STLink(l),STLink(r)]          : new stx.assert.schema.type.ord.LinkType().comply(l.pop(),r.pop());
        case [STEnum(l),STEnum(r)]          : new stx.assert.schema.type.ord.EnumType().comply(l.pop(),r.pop());
        case [l,r]                          : Ord.EnumValueIndex().comply(l,r);
    }
  }
}