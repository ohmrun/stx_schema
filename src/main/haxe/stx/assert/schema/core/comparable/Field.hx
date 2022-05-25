package stx.assert.schema.core.comparable;

import stx.schema.core.Field as TField;

class Field implements ComparableApi<TField>{
  public function new(){}
  public function lt(){
    return new stx.assert.schema.core.ord.Field();
  }
  public function eq(){
    return new stx.assert.schema.core.eq.Field();
  }
}