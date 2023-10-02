package stx.assert.schema.ord;

import stx.schema.Validations as TValidations;

class Validations extends OrdCls<TValidations>{
  public function new(){}
  public function comply(self:TValidations,that:TValidations){
    //return Ord.Cluster(new stx.assert.schema.ord.Validation()).comply(self,that);
    return throw UNIMPLEMENTED;
  }
}
