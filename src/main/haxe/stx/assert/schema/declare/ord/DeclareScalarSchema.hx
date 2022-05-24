package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareScalarSchema in TDeclareScalarSchema;

class DeclareScalarSchema extends OrdCls<TDeclareScalarSchema> {
  public function new(){}
  public function comply(lhs:TDeclareScalarSchema,rhs:TDeclareScalarSchema){
    var ord = new stx.assert.schema.declare.ord.DeclareSchema().comply((lhs:DeclareSchemaApi),(rhs:DeclareSchemaApi));
    if(ord.is_not_less_than()){
      ord = new stx.assert.g.ord.GComplexType().comply(lhs.ctype,rhs.ctype);
    }
    return ord;
  }
}
