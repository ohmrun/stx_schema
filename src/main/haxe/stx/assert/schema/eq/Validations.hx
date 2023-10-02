package stx.assert.schema.eq;

import stx.schema.Validations as TValidations;

abstract class Validations extends EqCls<TValidations>{
  public function new(){}
  // public function comply(self:TValidations,that:TValidations){
  //   return Eq.Cluster(new stx.assert.schema.eq.Validation()).comply(self,that);
  // }
}
