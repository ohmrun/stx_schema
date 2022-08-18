package stx.assert.schema.declare.ord;
import stx.schema.declare.ProcureAttribute in TProcureAttribute;

class ProcureAttribute extends OrdCls<TProcureAttribute> {
  public function new(){}
  public function comply(lhs:TProcureAttribute,rhs:TProcureAttribute){
    var ord = new stx.assert.schema.declare.ord.ProcureProperty().comply(
      ProcureProperty.make(lhs.name,lhs.type,lhs.validation,lhs.meta),
      ProcureProperty.make(rhs.name,rhs.type,rhs.validation,rhs.meta)
    );
    if(ord.is_not_less_than()){
      ord = new stx.assert.schema.ord.RelationType().comply(lhs.relation,rhs.relation);
    }
    if(ord.is_not_less_than()){
      ord = Ord.String().comply(lhs.inverse,rhs.inverse);
    }
    return ord;
  }
}
