package stx.assert.schema.ord;
import stx.schema.RelationType in TRelationType;

class RelationType extends OrdCls<TRelationType> {
  public function new(){}
  public function comply(lhs:TRelationType,rhs:TRelationType){
    return Ord.EnumValueIndex().comply(lhs,rhs);
  }
}
