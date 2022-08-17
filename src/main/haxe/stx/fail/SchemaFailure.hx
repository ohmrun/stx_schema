package stx.fail;

import stx.fail.*;

enum SchemaFailureSum{
  E_Schema_EnumValueError(should_be:Cluster<String>,actual:String);
  E_Schema_HaxeTypeError(should_be:ValueType,actual:ValueType);
  E_Schema_ValidationError(validation:Validation,caught:SchemaFailure);
  E_Schema_Dynamic(e:Dynamic);
  E_Schema_SchemaNotFound(identity:Identity);
  E_Schema_WrongSchemaType(type:Schema);
  E_Schema_WrongType(type:stx.schema.SType);
  E_Schema_TypeNotFound(type:stx.schema.SType);
  E_Schema_UnexpectedGeneric;
  E_Schema_UnexpectedType;
  E_Schema_IdentityUnresolved(identity:stx.schema.core.Identity);
  E_Schema_AttemptingToDefineUnsupportedType(type:stx.schema.SType);
  E_Schema_UnexpectedMono;
  E_Schema_LazyTypeEmpty;
  E_Schema_SchemaTypeNotSupportedHere;
  E_Schema_InverseNotFound(link:stx.schema.type.LinkType);
  E_Schema_Makro(err:stx.fail.MakroFailure);
  E_Schema_MakroTypeFailure(err:stx.fail.MakroTypeFailure);
}
abstract SchemaFailure(SchemaFailureSum) from SchemaFailureSum to SchemaFailureSum{
  public function new(self) this = self;
  @:noUsing static public function lift(self:SchemaFailureSum):SchemaFailure return new SchemaFailure(self);

  public function prj():SchemaFailureSum return this;
  private var self(get,never):SchemaFailure;
  private function get_self():SchemaFailure return lift(this);

  @:from static public function fromMakroFailure(self:stx.fail.MakroFailure){
    return lift(E_Schema_Makro(self));
  }
}