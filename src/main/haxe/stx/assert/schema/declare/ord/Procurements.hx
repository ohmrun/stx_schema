package stx.assert.schema.declare.ord;

import stx.schema.declare.Procurements in TProcurements;

class Procurements extends OrdCls<TProcurements> {
  public function new(){}
  public function comply(lhs:TProcurements,rhs:TProcurements){
    return new stx.assert.ds.ord.RedBlackSet(new stx.assert.schema.declare.ord.Procure()).comply(lhs,rhs);
  }
}