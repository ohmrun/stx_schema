package stx.assert.schema.eq;

import stx.schema.RelationType in TRelationType;

class RelationType extends EqCls<TRelationType> {
  public function new(){}
  public function comply(lhs:TRelationType,rhs:TRelationType){
    return Eq.EnumValueIndex().comply(lhs,rhs);
  }
}
