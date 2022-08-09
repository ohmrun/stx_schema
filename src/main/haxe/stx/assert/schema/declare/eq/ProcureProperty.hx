package stx.assert.schema.declare.eq;

import stx.schema.declare.ProcureProperty in TProcureProperty;

class ProcureProperty extends EqCls<TProcureProperty> {
  public function new(){}
  public function comply(lhs:TProcureProperty,rhs:TProcureProperty){
    var eq   = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_equal()){
      eq = new stx.assert.schema.eq.SchemaRef().comply(lhs.type,rhs.type);
    }
    if(eq.is_equal()){
      eq = new stx.assert.pml.eq.PExpr(Eq.Primitive()).comply(lhs.meta,rhs.meta);
    }
    return eq;
  }
}