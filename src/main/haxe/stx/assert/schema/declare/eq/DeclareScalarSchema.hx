package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareScalarSchema in TDeclareScalarSchema;

class DeclareScalarSchema extends EqCls<TDeclareScalarSchema> {
  public function new(){}
  public function comply(lhs:TDeclareScalarSchema,rhs:TDeclareScalarSchema){
    var ord = new stx.assert.schema.declare.eq.DeclareSchema().comply((lhs:DeclareSchemaApi),(rhs:DeclareSchemaApi));
    if(ord.is_equal()){
      ord = new stx.assert.g.eq.GComplexType().comply(lhs.ctype,rhs.ctype);
    }
    return ord;
  }
}
