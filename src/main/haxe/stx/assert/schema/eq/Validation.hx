package stx.assert.schema.eq;

import stx.schema.Validation as TValidation;

class Validation extends EqCls<TValidation>{
  public function new(){}
  public function comply(self:TValidation,that:TValidation){
    return switch([self,that]){
      case [ValidationExpr(exprI),ValidationExpr(exprII)] :
        new stx.assert.g.eq.GExpr().comply(exprI,exprII);
      case [ValidationType(typeI),ValidationType(typeII)] :
        var lhs = Type.getClassName(Type.getClass(typeI));
        var rhs = Type.getClassName(Type.getClass(typeI));
        Eq.String().comply(lhs,rhs);
      default : 
        Eq.EnumValueIndex().comply(self,that);
    }
  }
}
