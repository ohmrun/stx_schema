package stx.schema;

typedef SchemaGenericDeclarationDef = SchemaDeclarationDef & {
  final type : SchemaRef;
}
@:forward abstract SchemaGenericDeclaration(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaGenericDeclarationLift;
  public function new(self) this = self;
  static public function lift(self:SchemaGenericDeclarationDef):SchemaGenericDeclaration return new SchemaGenericDeclaration(self);

  static public function make(name,pack,type,?validation){
    return lift({
      name          : name,
      pack          : pack,
      type          : type,
      validation    : _.validation.concat(__.option(validation).defv([]))
    });
  }

  public function prj():SchemaGenericDeclarationDef return this;
  private var self(get,never):SchemaGenericDeclaration;
  private function get_self():SchemaGenericDeclaration return lift(this);
} 
class SchemaGenericDeclarationLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return [];
  } 
}