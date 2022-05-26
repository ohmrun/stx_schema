package stx.assert.schema.core.comparable;

import stx.schema.core.Field as TField;

class Field extends ComparableCls<TField>{
  public function new(){}
  public function lt(){
    return new stx.assert.schema.core.ord.Field();
  }
  public function eq(){
    return new stx.assert.schema.core.eq.Field();
  }
}