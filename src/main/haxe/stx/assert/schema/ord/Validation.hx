package stx.assert.schema.ord;

import stx.schema.Validation as TValidation;

class Validation extends OrdCls<TValidation>{
  public function new(){}
  public function comply(self:TValidation,that:TValidation){
    var ord = new stx.assert.query.ord.QExpr(new stx.assert.om.ord.term.Spine(Ord.String())).comply(self.method,that.method);
    if(ord.is_not_less_than()){
      ord = Ord.String().comply(self.message,that.message);
    }
    return ord;
  }
}
