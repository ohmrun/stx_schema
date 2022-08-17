package stx.assert.schema.declare.eq;

import stx.schema.declare.ProcureAttribute in TProcureAttribute;

class ProcureAttribute extends EqCls<TProcureAttribute> {
  public function new(){}
  public function comply(lhs:TProcureAttribute,rhs:TProcureAttribute){
    var eq = new stx.assert.schema.declare.eq.ProcureProperty().comply(
      ProcureProperty.make(lhs.name,lhs.type,lhs.validation,lhs.meta),
      ProcureProperty.make(rhs.name,rhs.type,rhs.validation,rhs.meta)
    );
    if(eq.is_equal()){
      eq = new stx.assert.schema.eq.RelationType().comply(lhs.relation,rhs.relation);
    }
    if(eq.is_equal()){
      eq = Eq.NullOr(Eq.String()).comply(lhs.inverse,rhs.inverse);
    }
    return eq;
  }
}