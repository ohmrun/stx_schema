package stx.assert.schema.eq;

import stx.schema.Validation as TValidation;

final Eq = __.assert().Eq();

abstract class Validation extends EqCls<TValidation>{
  public function new(){}
  public function comply(self:TValidation,that:TValidation){
    // var eq = new stx.assert.query.eq.QExpr(new stx.assert.pml.eq.PExpr(new stx.assert.pml.eq.Atom())).comply(self.method,that.method);
    // if(eq.is_equal()){
    //   eq = Eq.String().comply(self.message,that.message);
    // }
    // return eq;
    return throw UNIMPLEMENTED;
  }
}
