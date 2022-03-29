package stx.fail;

import stx.fail.*;

enum SchemaFailure{
  E_Schema_EnumValueError(should_be:Cluster<String>,actual:String);
  E_Schema_HaxeTypeError(should_be:ValueType,actual:ValueType);
  E_Schema_ValidationError(validation:Validation,caught:SchemaFailure);
  E_Schema_Dynamic(e:Dynamic);
  E_Schema_WrongSchemaType(type:Schema);
  E_Schema_WrongType(type:stx.schema.core.Type);
  E_Schema_UnexpectedGeneric;
  E_Schema_UnexpectedType;
  E_Schema_IdentityUnresolved(identity:stx.schema.core.Identity);
}