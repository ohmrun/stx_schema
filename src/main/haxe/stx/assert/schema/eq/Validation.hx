package stx.assert.schema.eq;

import stx.schema.Validation as TValidation;

class Validation extends EqCls<TValidation>{
  public function new(){}
  public function comply(self:TValidation,that:TValidation){
    return new stx.assert.query.eq.QExpr(new stx.assert.om.eq.term.Spine(Eq.String())).comply(self,that);
  }
}
