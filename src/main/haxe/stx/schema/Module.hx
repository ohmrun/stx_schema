package stx.schema;

class Module extends Clazz{
  public function scalar(name,pack,ctype,meta,?validation){
    return SchScalar(DeclareScalarSchema.make(Identity.make(Ident.make(name,pack),None,None),ctype,meta,validation));
  }
  public function record(self:{ name : String, ?pack : Cluster<String>, fields : Procurements, ?meta : PExpr<Primitive> , ?validation : Validations }){
    return SchRecord(DeclareRecordSchema.make0(self.name,self.pack,self.fields,self.meta,self.validation));
  }
  public function enumeration(name,pack,constructors,?meta,?validation){
    return SchEnum(DeclareEnumSchema.make0(name,pack,constructors,meta,validation));
  }
  public function generic(name,pack,type:SchemaRef,?meta,?validation){
    return SchGeneric(DeclareGenericSchema.make0(name,pack,type,meta,validation));
  }
  public function union(name,pack,type,lhs,rhs,?meta,?validation){
    return SchUnion(DeclareUnionSchema.make0(name,pack,lhs,rhs,validation));
  }
  public function type(type){
    return SchType(type);
  }
  public function property(type):DeclareProperty{
    return DeclareProperty.make(type);
  }
  public function attribute(type,relation,?inverse){
    return DeclareAttribute.make(type,relation,inverse);
  }
}
private class Type{

}