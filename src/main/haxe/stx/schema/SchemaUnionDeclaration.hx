package stx.schema;

typedef SchemaUnionDeclarationDef = SchemaDeclarationDef & {
  final types : Cluster<SchemaRef>;
}
@:forward abstract SchemaUnionDeclaration(SchemaUnionDeclarationDef) from SchemaUnionDeclarationDef to SchemaUnionDeclarationDef{
  static public var _(default,never) = SchemaUnionDeclarationLift;
  public function new(self) this = self;
  static public function lift(self:SchemaUnionDeclarationDef):SchemaUnionDeclaration return new SchemaUnionDeclaration(self);

  static public function make(name,pack,types,?validation){
    return lift({
      name          : name,
      pack          : pack,
      types         : types,
      validation    : _.validation.concat(__.option(validation).defv(Cluster.unit()))
    });
  }

  public function prj():SchemaUnionDeclarationDef return this;
  private var self(get,never):SchemaUnionDeclaration;
  private function get_self():SchemaUnionDeclaration return lift(this);
} 
class SchemaUnionDeclarationLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  } 
}