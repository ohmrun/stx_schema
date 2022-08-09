package stx.assert.schema.ord;

import stx.schema.SchemaRef in TSchemaRef;

class SchemaRef extends OrdCls<TSchemaRef> {
  public function new(){}
  public function comply(lhs:TSchemaRef,rhs:TSchemaRef){
    var ord = new stx.assert.schema.core.ord.Identity().comply(lhs.identity,rhs.identity);
    if(ord.is_not_less_than()){
      ord = Ord.Exists().comply(lhs.pop,rhs.pop);
    }
    return ord;
  }
}
