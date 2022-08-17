package stx.schema;

import eu.ohmrun.halva.Core;

class Context extends Stock<String,SType>{
  public function new(){
    final satisfies = new ContextSatisfies();
    super(
      satisfies,
      RedBlackMap.make(
        Comparable.Register()
      ),
      new haxe.ds.Map()
    );
  }
}
private class ContextSatisfies extends SatisfiesCls<SType>{
  public function new(){}
  public function lub(){
    return new eu.ohmrun.halva.schema.Lub();
  }
  public function eq(){
    return new stx.assert.halva.eq.LVar(new stx.assert.schema.type.eq.SType());
  }
  public function lt(){
    return new stx.assert.halva.ord.LVar(new stx.assert.schema.type.ord.SType());
  }
}