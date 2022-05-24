package stx.assert.schema.type.ord;

import stx.schema.core.Identity as TIdentity;

class Identity extends OrdCls<TIdentity>{
  public function new(){}
  public function comply(lhs:TIdentity,rhs:TIdentity){
    var ord = Ord.Ident().comply(Ident.make(lhs.name,lhs.pack),Ident.make(rhs.name,rhs.pack));
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(this)).comply(lhs.rest,rhs.rest);
    }
    return ord;
  }
}