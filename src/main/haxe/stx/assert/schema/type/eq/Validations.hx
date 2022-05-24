package stx.assert.schema.type.eq;

import stx.schema.Validations as TValidations;

class Validations extends EqCls<TValidations>{
  public function new(){}
  public function comply(self:TValidations,that:TValidations){
    return Eq.Cluster(new stx.assert.schema.type.eq.Validation()).comply(self,that);
  }
}
