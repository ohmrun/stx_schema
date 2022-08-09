package stx.assert.schema.eq;

import stx.schema.SchemaRef in TSchemaRef;

class SchemaRef extends EqCls<TSchemaRef> {
  public function new(){}
  public function comply(lhs:TSchemaRef,rhs:TSchemaRef){
    var eq = new stx.assert.schema.core.eq.Identity().comply(lhs.identity,rhs.identity);
    if(eq.is_equal()){
      eq = Eq.NullOr(Eq.Anon((x,y) -> x == y)).comply(lhs.pop,rhs.pop);
    }
    return eq;
  }
}
