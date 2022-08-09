package stx.assert.schema.declare.ord;

import stx.schema.declare.Procure in TProcure;

class Procure extends OrdCls<TProcure>{
  public function new(){}
  public function comply(lhs:TProcure,rhs:TProcure){
    return switch([lhs,rhs]){
      case [Property(defI),Property(defII)]   : 
        new stx.assert.schema.declare.ord.ProcureProperty().comply(defI,defII);
      case [Attribute(defI),Attribute(defII)] :
        new stx.assert.schema.declare.ord.ProcureAttribute().comply(defI,defII);
      default : Ord.EnumValueIndex().comply(lhs,rhs);
    }
  }
}