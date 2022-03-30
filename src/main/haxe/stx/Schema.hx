package stx;

class SchemaModuleCtr{
  static public function schema(wildcard:Wildcard){
    return new stx.schema.Module();
  } 
}
typedef SchemaFailure                             = stx.fail.SchemaFailure;

typedef SchemaDeclaration                         = stx.schema.SchemaDeclaration;
typedef SchemaDeclarationDef                      = stx.schema.SchemaDeclaration.SchemaDeclarationDef;

typedef SchemaRecordDeclaration                   = stx.schema.SchemaRecordDeclaration;
typedef SchemaRecordDeclarationDef                = stx.schema.SchemaRecordDeclaration.SchemaRecordDeclarationDef;

typedef SchemaGenericDeclaration                  = stx.schema.SchemaGenericDeclaration;
typedef SchemaGenericDeclarationDef               = stx.schema.SchemaGenericDeclaration.SchemaGenericDeclarationDef;

typedef SchemaUnionDeclaration                    = stx.schema.SchemaUnionDeclaration;
typedef SchemaUnionDeclarationDef                 = stx.schema.SchemaUnionDeclaration.SchemaUnionDeclarationDef;

typedef SchemaPropertyRef                         = stx.schema.SchemaPropertyRef;
typedef SchemaPropertyRefDef                      = stx.schema.SchemaPropertyRef.SchemaPropertyRefDef;

// typedef SchemaAnonDeclaration                     = stx.schema.SchemaAnonDeclaration;
// typedef SchemaAnonDeclarationDef                  = stx.schema.SchemaAnonDeclaration.SchemaAnonDeclarationDef;

typedef Schema                                    = stx.schema.Schema;
typedef SchemaSum                                 = stx.schema.Schema.SchemaSum;

typedef SchemaRelationSum                         = stx.schema.SchemaRelationSum;

typedef SchemaRef                                 = stx.schema.SchemaRef;
typedef SchemaRefDef                              = stx.schema.SchemaRef.SchemaRefDef;

typedef ValidationSum                             = stx.schema.Validation.ValidationSum;
typedef Validation                                = stx.schema.Validation;
typedef Validations                               = stx.schema.Validations;
typedef WithValidationDef                         = stx.schema.WithValidationDef;

typedef Procurement                               = stx.schema.Procurement;
typedef ProcurementSum                            = stx.schema.Procurement.ProcurementSum;

typedef Procurements                              = stx.schema.Procurements;
typedef ProcurementsDef                           = stx.schema.Procurements.ProcurementsDef;


typedef PropertyDeclaration                       = stx.schema.PropertyDeclaration;
typedef PropertyDeclarationDef                    = stx.schema.PropertyDeclaration.PropertyDeclarationDef;

typedef AttributeDeclaration                      = stx.schema.AttributeDeclaration;
typedef AttributeDeclarationDef                   = stx.schema.AttributeDeclaration.AttributeDeclarationDef;

typedef ProcurementAttributeDeclarationDef        = stx.schema.ProcurementAttributeDeclaration.ProcurementAttributeDeclarationDef;
typedef ProcurementAttributeDeclaration           = stx.schema.ProcurementAttributeDeclaration; 

typedef ProcurementPropertyDeclarationDef         = stx.schema.ProcurementPropertyDeclaration.ProcurementPropertyDeclarationDef;
typedef ProcurementPropertyDeclaration            = stx.schema.ProcurementPropertyDeclaration; 

typedef Schemata                                  = stx.schema.Schemata;
typedef SchemataCls                               = stx.schema.Schemata.SchemataCls;
typedef ValidationComplyApi                       = ComplyApi<Dynamic,stx.schema.core.Type,Report<SchemaFailure>>;
typedef ValidationComplyCls                       = ComplyCls<Dynamic,stx.schema.core.Type,Report<SchemaFailure>>;