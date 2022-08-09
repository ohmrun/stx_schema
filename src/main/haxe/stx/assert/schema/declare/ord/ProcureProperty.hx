package stx.assert.schema.declare.ord;

import stx.schema.declare.ProcureProperty in TProcureProperty;

class ProcureProperty extends OrdCls<TProcureProperty> {
  public function new(){}
  public function comply(lhs:TProcureProperty,rhs:TProcureProperty){
    var ord   = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = new stx.assert.schema.ord.SchemaRef().comply(lhs.type,rhs.type);
    }
    if(ord.is_not_less_than()){
      ord = new stx.assert.pml.ord.PExpr(Ord.Primitive()).comply(lhs.meta,rhs.meta);
    }
    return ord;
  }
}
