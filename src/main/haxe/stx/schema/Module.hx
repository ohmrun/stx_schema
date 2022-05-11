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
  public function property(type,?meta):DeclareProperty{
    return DeclareProperty.make(type,__.option(meta).defv(Empty));
  }
  public function attribute(type,relation,meta,?inverse,?validation){
    return DeclareAttribute.make(type,relation,meta,inverse,validation);
  }
}
private class Type{

}