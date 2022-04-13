package stx;

class SchemaModuleCtr{
  static public function schema(wildcard:Wildcard){
    return new stx.schema.Module();
  } 
}
typedef SchemaFailure                             = stx.fail.SchemaFailure;
typedef SchemaFailureSum                          = stx.fail.SchemaFailure.SchemaFailureSum;

typedef DeclareSchema                             = stx.schema.declare.DeclareSchema;
typedef DeclareSchemaDef                          = stx.schema.declare.DeclareSchema.DeclareSchemaDef;

typedef DeclareRecordSchema                       = stx.schema.declare.DeclareRecordSchema;
typedef DeclareRecordSchemaDef                    = stx.schema.declare.DeclareRecordSchema.DeclareRecordSchemaDef;

typedef DeclareGenericSchema                      = stx.schema.declare.DeclareGenericSchema;
typedef DeclareGenericSchemaDef                   = stx.schema.declare.DeclareGenericSchema.DeclareGenericSchemaDef;

typedef DeclareUnionSchema                        = stx.schema.declare.DeclareUnionSchema;
typedef DeclareUnionSchemaDef                     = stx.schema.declare.DeclareUnionSchema.DeclareUnionSchemaDef;

typedef DeclareEnumSchema                         = stx.schema.declare.DeclareEnumSchema;
typedef DeclareEnumSchemaDef                      = stx.schema.declare.DeclareEnumSchema.DeclareEnumSchemaDef;

typedef Procure                                   = stx.schema.declare.Procure;
typedef ProcureSum                                = stx.schema.declare.Procure.ProcureSum;

typedef Procurements                              = stx.schema.declare.Procurements;
typedef ProcurementsDef                           = stx.schema.declare.Procurements.ProcurementsDef;

typedef DeclareProperty                           = stx.schema.declare.DeclareProperty;
typedef DeclarePropertyDef                        = stx.schema.declare.DeclareProperty.DeclarePropertyDef;

typedef DeclareAttribute                          = stx.schema.declare.DeclareAttribute;
typedef DeclareAttributeDef                       = stx.schema.declare.DeclareAttribute.DeclareAttributeDef;

typedef ProcureAttributeDef                       = stx.schema.declare.ProcureAttribute.ProcureAttributeDef;
typedef ProcureAttribute                          = stx.schema.declare.ProcureAttribute; 

typedef ProcurePropertyDef                        = stx.schema.declare.ProcureProperty.ProcurePropertyDef;
typedef ProcureProperty                           = stx.schema.declare.ProcureProperty; 


// typedef SchemaAnonDeclaration                     = stx.schema.SchemaAnonDeclaration;
// typedef SchemaAnonDeclarationDef                  = stx.schema.SchemaAnonDeclaration.SchemaAnonDeclarationDef;

typedef Schema                                    = stx.schema.Schema;
typedef SchemaSum                                 = stx.schema.Schema.SchemaSum;

typedef RelationType                              = stx.schema.RelationType;

typedef SchemaRef                                 = stx.schema.SchemaRef;
typedef SchemaRefDef                              = stx.schema.SchemaRef.SchemaRefDef;

typedef ValidationSum                             = stx.schema.Validation.ValidationSum;
typedef Validation                                = stx.schema.Validation;
typedef Validations                               = stx.schema.Validations;
typedef WithValidationDef                         = stx.schema.WithValidationDef;

typedef TyperContext                              = stx.schema.TyperContext;
typedef TyperContextCls                           = stx.schema.TyperContext.TyperContextCls;
typedef ValidationComplyApi                       = ComplyApi<Dynamic,stx.schema.core.SType,Report<SchemaFailure>>;
typedef ValidationComplyCls                       = ComplyCls<Dynamic,stx.schema.core.SType,Report<SchemaFailure>>;