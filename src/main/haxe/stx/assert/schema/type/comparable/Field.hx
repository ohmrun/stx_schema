package stx.assert.schema.type.comparable;

import stx.schema.core.Field as TField;

class Field implements ComparableApi<TField>{
  public function new(){}
  public function lt(){
    return new stx.assert.schema.type.ord.Field();
  }
  public function eq(){
    return new stx.assert.schema.type.eq.Field();
  }
}