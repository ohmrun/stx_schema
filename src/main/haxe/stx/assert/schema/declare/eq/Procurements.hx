package stx.assert.schema.declare.eq;

import stx.schema.declare.Procurements in TProcurements;

class Procurements extends EqCls<TProcurements> {
  public function new(){}
  public function comply(lhs:TProcurements,rhs:TProcurements){
    return new stx.assert.ds.eq.RedBlackSet(new stx.assert.schema.declare.eq.Procure()).comply(lhs,rhs);
  }
}