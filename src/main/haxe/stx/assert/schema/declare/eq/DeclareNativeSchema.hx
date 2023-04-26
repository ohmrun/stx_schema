package stx.assert.schema.declare.eq;

import stx.schema.declare.DeclareNativeSchema in TDeclareNativeSchema;

class DeclareNativeSchema extends EqCls<TDeclareNativeSchema> {
  public function new(){}
  public function comply(lhs:TDeclareNativeSchema,rhs:TDeclareNativeSchema){
    var ord = new stx.assert.schema.declare.eq.DeclareSchema().comply((lhs:DeclareSchemaApi),(rhs:DeclareSchemaApi));
    if(ord.is_equal()){
      ord = new stx.assert.glot.eq.GComplexType().comply(lhs.ctype,rhs.ctype);
    }
    return ord;
  }
}
