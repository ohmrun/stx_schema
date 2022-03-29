package stx.schema;

typedef TypeStatus                  = stx.schema.core.type.TypeStatus;

typedef BaseTypeApi                 = stx.schema.core.type.BaseType.BaseTypeApi;
typedef BaseTypeCls                 = stx.schema.core.type.BaseType.BaseTypeCls;


typedef FieldDef                    = stx.schema.core.type.Field.FieldDef;
typedef Field                       = stx.schema.core.type.Field;

typedef TypeSum                     = stx.schema.core.Type.TypeSum;
typedef Type                        = stx.schema.core.Type;

typedef DataTypeApi                 = stx.schema.core.type.DataType.DataTypeApi;
typedef DataTypeCls                 = stx.schema.core.type.DataType.DataTypeCls;
typedef DataType                    = stx.schema.core.type.DataType;

typedef AnonTypeApi                 = stx.schema.core.type.AnonType.AnonTypeApi;
typedef AnonTypeCls                 = stx.schema.core.type.AnonType.AnonTypeCls;
typedef AnonType                    = stx.schema.core.type.AnonType;

typedef RecordTypeApi               = stx.schema.core.type.RecordType.RecordTypeApi;
typedef RecordTypeCls               = stx.schema.core.type.RecordType.RecordTypeCls;
typedef RecordType                  = stx.schema.core.type.RecordType;

typedef GenericTypeApi              = stx.schema.core.type.GenericType.GenericTypeApi;
typedef GenericTypeCls              = stx.schema.core.type.GenericType.GenericTypeCls;
typedef GenericType                 = stx.schema.core.type.GenericType;

typedef UnionTypeCls                = stx.schema.core.type.UnionType.UnionTypeCls;
typedef UnionTypeApi                = stx.schema.core.type.UnionType.UnionTypeApi;
typedef UnionType                   = stx.schema.core.type.UnionType;

typedef TypeKind                    = stx.schema.core.type.TypeKind;

typedef LinkTypeCls                 = stx.schema.core.type.LinkType.LinkTypeCls;
typedef LinkTypeApi                 = stx.schema.core.type.LinkType.LinkTypeApi;
typedef LinkType                    = stx.schema.core.type.LinkType;

typedef EnumTypeApi                 = stx.schema.core.type.EnumType.EnumTypeApi;
typedef EnumTypeCls                 = stx.schema.core.type.EnumType.EnumTypeCls;
typedef EnumType                    = stx.schema.core.type.EnumType;

typedef Has_toStringDef             = stx.schema.core.type.Has_toStringDef;
typedef Has_toStringApi             = stx.schema.core.type.Has_toString.Has_toStringApi;
typedef Has_toStringCls             = stx.schema.core.type.Has_toString.Has_toStringCls;

typedef Ref<T:Has_toStringDef>      = stx.schema.core.Ref<T>;
typedef RefDef<T:Has_toStringDef>   = stx.schema.core.Ref.RefDef<T>;

typedef WithValidationCls           = stx.schema.core.WithValidation.WithValidationCls;
typedef WithValidationApi           = stx.schema.core.WithValidation.WithValidationApi;

typedef Identity                    = stx.schema.core.Identity;
typedef Context                     = stx.schema.core.Context;


// typedef LinkTypeDef                 = stx.schema.core.type.LinkType.LinkTypeDef;
// typedef LinkType                    = stx.schema.core.type.LinkType

// typedef SchemaBool                  = stx.schema.core.type.term.SchemaBool;
// typedef SchemaInt                   = stx.schema.core.type.term.SchemaInt;
// typedef SchemaString                = stx.schema.core.type.term.SchemaString;
// typedef SchemaNull                  = stx.schema.core.type.term.SchemaNull;
