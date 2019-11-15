package stx.schema;

typedef Relationship        = stx.schema.pack.Relationship;
typedef RelationDefinition  = stx.schema.pack.RelationDefinition;
typedef ComplexType         = stx.schema.pack.ComplexType;
typedef Import              = stx.schema.pack.Import;
typedef MetaData            = stx.schema.pack.MetaData;

enum Unique{
  Identity;
  Value;
}



typedef SchemaDeclaration = 
        IdentT            &
{
  //@:optional public var attributes  : DynamicAccess<AttributeDeclaration>;//requires querying another table
  @:optional public var properties  : DynamicAccess<ComplexType>;
  @:optional public var metadata    : MetaData;

}

typedef AttributeDeclaration = {
  var relation  : RelationDefinition;
}

enum NativeCall{
  HasValueType(vt:ValueType);
}

typedef SchemaDefinitionT     = 
        SpecificationT        &
        IdentT                &
  {
    
  }

abstract SchemaDefinition(SchemaDefinitionT) from SchemaDefinitionT to SchemaDefinitionT{
  function new(self) {
    this = self;
  }
}

typedef SpecificationT = {
  var access : Any;
  var fields : StringMap<Field>;
}

abstract Specification(SpecificationT) from SpecificationT to SpecificationT {
  
}

typedef Field  = {
  var type : ComplexType;
}

/*






*/