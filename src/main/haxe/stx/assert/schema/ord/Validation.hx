package stx.assert.schema.ord;

import stx.schema.Validation as TValidation;

abstract class Validation extends OrdCls<TValidation>{
  public function new(){}
  public function comply(self:TValidation,that:TValidation){
    // var ord = new stx.assert.query.ord.QExpr(new stx.assert.pml.ord.PExpr(new stx.assert.pml.ord.Atom())).comply(self.method,that.method);
    // if(ord.is_not_less_than()){
    //   ord = Ord.String().comply(self.message,that.message);
    // }
    // return ord;
    return throw UNIMPLEMENTED;
  }
}
