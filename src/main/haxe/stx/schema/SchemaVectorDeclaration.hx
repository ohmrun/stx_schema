package stx.schema;

typedef SchemaVectorDeclarationDef = SchemaDeclarationDef & {
  final type : SchemaRef;
}
@:forward abstract SchemaVectorDeclaration(SchemaVectorDeclarationDef) from SchemaVectorDeclarationDef to SchemaVectorDeclarationDef{
  static public var _(default,never) = SchemaVectorDeclarationLift;
  public function new(self) this = self;
  static public function lift(self:SchemaVectorDeclarationDef):SchemaVectorDeclaration return new SchemaVectorDeclaration(self);

  static public function make(name,pack,type,?validation){
    return lift({
      id            : Identity.fromIdent(Ident.make(name,pack)),
      type          : type,
      validation    : _.validation.concat(__.option(validation).defv(Cluster.unit()))
    });
  }

  public function prj():SchemaVectorDeclarationDef return this;
  private var self(get,never):SchemaVectorDeclaration;
  private function get_self():SchemaVectorDeclaration return lift(this);
} 
class SchemaVectorDeclarationLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  } 
}