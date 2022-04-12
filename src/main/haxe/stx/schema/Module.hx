package stx.schema;

class Module extends Clazz{
  public function scalar(name,pack,?validation){
    return SchScalar(SchemaDeclaration.make(name,pack,None,None,validation));
  }
  public function record(self:{ name : String, ?pack : Cluster<String>, fields : Procurements, ?validation : Validations }){
    return SchRecord(SchemaRecordDeclaration.make0(self.name,self.pack,self.fields,self.validation));
  }
  public function enumeration(name,pack,constructors,?validation){
    return SchEnum(SchemaEnumDeclaration.make0(name,pack,constructors,validation));
  }
  public function generic(name,pack,type,?validation){
    return SchGeneric(SchemaGenericDeclaration.make(name,pack,type,validation));
  }
  public function union(name,pack,type,lhs,rhs,?validation){
    return SchUnion(SchemaUnionDeclaration.make0(name,pack,lhs,rhs,validation));
  }
  public function type(type){
    return SchType(type);
  }
}
private class Type{

}