package stx.assert.schema.ord;

import stx.schema.Validation as TValidation;

class Validation extends OrdCls<TValidation>{
  public function new(){}
  public function comply(self:TValidation,that:TValidation){
    return new stx.assert.query.ord.QExpr(new stx.assert.om.ord.term.Spine(Ord.String())).comply(self,that);
  }
}
