package stx.schema;

typedef Field                       = stx.schema.core.Field.FieldSum;
typedef FieldSum                    = stx.schema.core.Field;

typedef TypeDef                     = stx.schema.core.Type.TypeDef;
typedef Type                        = stx.schema.core.Type;

typedef DataTypeDef                 = stx.schema.core.type.DataType.DataTypeDef;
typedef DataType                    = stx.schema.core.type.DataType;

typedef AnonTypeDef                 = stx.schema.core.type.AnonType.AnonTypeDef;
typedef AnonType                    = stx.schema.core.type.AnonType;

typedef RecordTypeDef               = stx.schema.core.type.RecordType.RecordTypeDef;
typedef RecordType                  = stx.schema.core.type.RecordType;

typedef GenericTypeDef              = stx.schema.core.type.GenericType.GenericTypeDef;
typedef GenericType                 = stx.schema.core.type.GenericType;

typedef UnionTypeDef                = stx.schema.core.type.UnionType.UnionTypeDef;
typedef UnionType                   = stx.schema.core.type.UnionType;

typedef TypeKind                    = stx.schema.core.type.TypeKind;

typedef LinkTypeDef                 = stx.schema.core.type.LinkType.LinkTypeDef;
typedef LinkType                    = stx.schema.core.type.LinkType;

typedef LazyTypeDef                 = stx.schema.core.type.LazyType.LazyTypeDef;
typedef LazyType                    = stx.schema.core.type.LazyType;

typedef Has_toStringDef             = stx.schema.core.type.Has_toStringDef;

typedef Ref<T:Has_toStringDef>      = stx.schema.core.Ref<T>;
typedef RefDef<T:Has_toStringDef>   = stx.schema.core.Ref.RefDef<T>;
// typedef LinkTypeDef                 = stx.schema.core.type.LinkType.LinkTypeDef;
// typedef LinkType                    = stx.schema.core.type.LinkType

// typedef SchemaBool                  = stx.schema.core.type.term.SchemaBool;
// typedef SchemaInt                   = stx.schema.core.type.term.SchemaInt;
// typedef SchemaString                = stx.schema.core.type.term.SchemaString;
// typedef SchemaNull                  = stx.schema.core.type.term.SchemaNull;
