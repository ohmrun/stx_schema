package stx.schema;

class Module extends Clazz{
  public function scalar(name,pack,?validation){
    return SchScalar(DeclareSchema.make(name,pack,None,None,validation));
  }
  public function record(self:{ name : String, ?pack : Cluster<String>, fields : Procurements, ?validation : Validations }){
    return SchRecord(DeclareRecordSchema.make0(self.name,self.pack,self.fields,self.validation));
  }
  public function enumeration(name,pack,constructors,?validation){
    return SchEnum(DeclareEnumSchema.make0(name,pack,constructors,validation));
  }
  public function generic(name,pack,type,?validation){
    return SchGeneric(DeclareGenericSchema.make(name,pack,type,validation));
  }
  public function union(name,pack,type,lhs,rhs,?validation){
    return SchUnion(DeclareUnionSchema.make0(name,pack,lhs,rhs,validation));
  }
  public function type(type){
    return SchType(type);
  }
}
private class Type{

}