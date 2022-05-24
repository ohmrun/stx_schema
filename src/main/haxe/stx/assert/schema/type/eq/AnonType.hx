package stx.assert.schema.type.eq;

import stx.schema.type.AnonType as TAnonType;

class AnonType extends EqCls<TAnonType>{
  public function new(){}
  public function comply(lhs:TAnonType,rhs:TAnonType){
    var eq = Eq.Int().comply(lhs.fields.pop().length,rhs.fields.pop().length);
    if(eq.is_equal()){
      var set_l = RedBlackSet.make(new stx.assert.schema.core.comparable.Field());
            set_l = set_l.concat(lhs.fields.pop());
      var set_r = RedBlackSet.make(new stx.assert.schema.core.comparable.Field());
            set_r = set_r.concat(rhs.fields.pop());
      eq = set_l.equals(set_r);
    }
    return eq;
  }
}