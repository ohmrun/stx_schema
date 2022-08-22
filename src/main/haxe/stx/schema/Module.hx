package stx.schema;

class Module extends Clazz{
  public function scalar(name,pack,?ctype,?validation,?meta){
    final ident = Ident.make(name,pack);
    return SchScalar(DeclareScalarSchema.make(ident,ctype,validation,meta));
  }
  public function record(self:{ name : String, ?pack : Cluster<String>, fields : Procurements, ?meta : PExpr<Primitive> , ?validation : Validations }):Schema{
    return SchRecord(DeclareRecordSchema.make0(self.name,self.pack,self.fields,self.meta,self.validation));
  }
  public function enumeration(ident,constructors,?validation,?meta):Schema{
    return SchEnum(DeclareEnumSchema.make(ident,constructors,validation,meta));
  }
  public function generic(ident,type:SchemaRef,?validation,?meta):Schema{
    return SchGeneric(DeclareGenericSchema.make(ident,type,validation,meta));
  }
  public function union(ident,rest,?validation,?meta):Schema{
    return SchUnion(DeclareUnionSchema.make(ident,rest,validation,meta));
  }
  public function property(type,?meta):DeclareProperty{
    return DeclareProperty.make(type,__.option(meta).defv(PEmpty));
  }
  public function attribute(type,relation,?inverse,?validation,?meta):DeclareAttribute{
    return DeclareAttribute.make(type,relation,inverse,validation,meta);
  }
}
private class Type{

}