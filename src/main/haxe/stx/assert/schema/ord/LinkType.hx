package stx.assert.schema.ord;

import stx.schema.type.LinkType as TLinkType;

class LinkType extends OrdCls<TLinkType>{
  public function new(){}
  public function comply(lhs:TLinkType,rhs:TLinkType){
    var ord = new stx.assert.schema.ord.SType().comply(lhs.into,rhs.into);
    if(ord.is_not_less_than()){
      ord = Ord.EnumValueIndex().comply(lhs.relation,rhs.relation);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(lhs.inverse,rhs.inverse);
    }
    return ord;
  }
}