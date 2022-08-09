package stx.assert.schema.declare.comparable;

import stx.schema.declare.Procurements in TProcurements;

class Procurements extends ComparableCls<TProcurements> {
  public function new(){}
  public function lt(){
    return new stx.assert.ds.ord.RedBlackSet(new stx.assert.schema.declare.ord.Procure());
  }
  public function eq(){
    return new stx.assert.ds.eq.RedBlackSet(new stx.assert.schema.declare.eq.Procure());
  }
}