package stx.assert.schema.eq;

import stx.schema.type.LinkType as TLinkType;

class LinkType extends EqCls<TLinkType>{
  public function new(){}
  public function comply(lhs:TLinkType,rhs:TLinkType){
    var eq = new stx.assert.schema.eq.SType().comply(lhs.into,rhs.into);
    if(eq.is_equal()){
      eq = Eq.EnumValueIndex().comply(lhs.relation,rhs.relation);
    }
    if(eq.is_equal()){
      eq = Eq.NullOr(Eq.String()).comply(lhs.inverse,rhs.inverse);
    }
    return eq;
  }
}