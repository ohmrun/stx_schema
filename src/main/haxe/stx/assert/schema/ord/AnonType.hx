package stx.assert.schema.ord;

import stx.schema.type.AnonType as TAnonType;

class AnonType extends OrdCls<TAnonType>{
  public function new(){}
  public function comply(lhs:TAnonType,rhs:TAnonType){
    return throw UNIMPLEMENTED;
  }
}