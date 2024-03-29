package stx.fail;

import Type;
using stx.Pico;
using stx.Nano;
using stx.Schema;
using stx.schema.Core;



enum SchemaFailureSum{
  E_Schema_EnumValueError(should_be:Cluster<String>,actual:String);
  E_Schema_HaxeTypeError(should_be:ValueType,actual:ValueType);
  //E_Schema_ValidationError(validation:Validation,caught:SchemaFailure);
  E_Schema_Top;
  E_Schema_Dynamic(e:Dynamic);
  E_Schema_SchemaNotFound(identity:Identity);
  E_Schema_NativeShouldBe(type:PrimitiveType);
  //E_Schema_NoTemplateFieldInType(field:String,type:DatabaseType);
  //E_Schema_TemplateTeminationOnObject(field:String,type:DatabaseType);
  //E_Schema_LookingForTemplateInType(template:Template,type:DatabaseType);
  E_Schema_RequireFieldsDeclaration(template:Template);
  //E_Schema_NoFieldInType(field_name:String,type:DatabaseType);
  E_Schema_WrongSchemaType(type:Schema);
  //E_Schema_WrongType(type:stx.schema.DatabaseType);
  //E_Schema_TypeNotFound(type:stx.schema.DatabaseType);
  E_Schema_UnexpectedGeneric;
  E_Schema_UnexpectedType;
  E_Schema_IdentityUnresolved(identity:stx.schema.core.Identity);
  //E_Schema_AttemptingToDefineUnsupportedType(type:stx.schema.DatabaseType);
  E_Schema_UnexpectedMono;
  E_Schema_LazyTypeEmpty;
  E_Schema_SchemaTypeNotSupportedHere;
  //E_Schema_InverseNotFound(link:stx.schema.type.LinkType);
  //E_Schema_Makro(err:stx.fail.MakroFailure);
  //E_Schema_MakroTypeFailure(err:stx.fail.MakroTypeFailure);
}
abstract SchemaFailure(SchemaFailureSum) from SchemaFailureSum to SchemaFailureSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:SchemaFailureSum):SchemaFailure return new SchemaFailure(self);

  public function prj():SchemaFailureSum return this;
  private var self(get,never):SchemaFailure;
  private function get_self():SchemaFailure return lift(this);

  // @:from static public function fromMakroFailure(self:stx.fail.MakroFailure){
  //   return lift(E_Schema_Makro(self));
  // }
}