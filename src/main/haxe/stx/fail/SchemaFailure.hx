package stx.fail;

import stx.fail.*;

enum SchemaFailure{
  E_Schema_EnumValueError(should_be:Array<String>,actual:String);
  E_Schema_HaxeTypeError(should_be:ValueType,actual:ValueType);
  E_Schema_ValidationError(validation:Validation,caught:SchemaFailure);
  E_Schema_Dynamic(e:Dynamic);
  E_Schema_WrongSchemaType(type:Schema);
}