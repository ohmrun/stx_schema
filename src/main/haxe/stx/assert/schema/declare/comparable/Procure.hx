package stx.assert.schema.declare.comparable;

import stx.schema.declare.Procure in TProcure;

class Procure extends ComparableCls<TProcure>{
  public function new(){}
  public function lt(){
    return new stx.assert.schema.declare.ord.Procure();
  }
  public function eq(){
    return new stx.assert.schema.declare.eq.Procure();
  }
}