package stx.assert.schema.declare.ord;

import stx.schema.declare.DeclareNativeSchema in TDeclareNativeSchema;

class DeclareNativeSchema extends OrdCls<TDeclareNativeSchema> {
  public function new(){}
  public function comply(lhs:TDeclareNativeSchema,rhs:TDeclareNativeSchema){
    var ord = new stx.assert.schema.declare.ord.DeclareSchema().comply((lhs:DeclareSchemaApi),(rhs:DeclareSchemaApi));
    if(ord.is_not_less_than()){
      ord = new stx.assert.glot.ord.GComplexType().comply(lhs.ctype,rhs.ctype);
    }
    return ord;
  }
}
