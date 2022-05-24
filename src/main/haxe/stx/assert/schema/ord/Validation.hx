package stx.assert.schema.ord;

import stx.schema.Validation as TValidation;

class Validation extends OrdCls<TValidation>{
  public function new(){}
  public function comply(self:TValidation,that:TValidation){
    return switch([self,that]){
      case [ValidationExpr(exprI),ValidationExpr(exprII)] :
        new stx.assert.g.ord.GExpr().comply(exprI,exprII);
      case [ValidationType(typeI),ValidationType(typeII)] :
        var lhs = Type.getClassName(Type.getClass(typeI));
        var rhs = Type.getClassName(Type.getClass(typeI));
        Ord.String().comply(lhs,rhs);
      default : 
        Ord.EnumValueIndex().comply(self,that);
    }
  }
}
