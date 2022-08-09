package stx.assert.schema.declare.eq;

import stx.schema.declare.Procure in TProcure;

class Procure extends EqCls<TProcure>{
  public function new(){}
  public function comply(lhs:TProcure,rhs:TProcure){
    return switch([lhs,rhs]){
      case [Property(defI),Property(defII)]   : 
        new stx.assert.schema.declare.eq.ProcureProperty().comply(defI,defII);
      case [Attribute(defI),Attribute(defII)] :
        new stx.assert.schema.declare.eq.ProcureAttribute().comply(defI,defII);
      default : 
        Eq.EnumValueIndex().comply(lhs,rhs);
    }
  }
}