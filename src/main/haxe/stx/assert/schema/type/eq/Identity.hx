package stx.assert.schema.type.eq;

import stx.schema.core.Identity as TIdentity;

class Identity extends EqCls<TIdentity>{
  public function new(){}
  public function comply(lhs:TIdentity,rhs:TIdentity){
    var eq = Eq.Ident().comply(Ident.make(lhs.name,lhs.pack),Ident.make(rhs.name,rhs.pack));
    if(eq.is_equal()){
      eq = Eq.NullOr(Eq.Cluster(this)).comply(lhs.rest,rhs.rest);
    }
    return eq;
  }
}