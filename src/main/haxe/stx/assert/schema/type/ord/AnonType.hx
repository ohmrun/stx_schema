package stx.assert.schema.type.ord;

import stx.schema.type.AnonType as TAnonType;

class AnonType extends OrdCls<TAnonType>{
  public function new(){}
  public function comply(lhs:TAnonType,rhs:TAnonType){
    var ord = Ord.Int().comply(lhs.fields.pop().length,rhs.fields.pop().length);
    if(ord.is_not_less_than()){
      var set_l = RedBlackSet.make(new stx.assert.schema.type.comparable.Field());
            set_l = set_l.concat(lhs.fields.pop());
      var set_r = RedBlackSet.make(new stx.assert.schema.type.comparable.Field());
            set_r = set_r.concat(rhs.fields.pop());
      ord = set_l.less_than(set_r);
    }
    return ord;
  }
}