package stx.schema;

typedef SchemaDeclarationDef = stx.schema.WithValidationDef & {
  final id : stx.schema.core.Identity;
}

@:using(stx.schema.SchemaDeclaration.SchemaDeclarationLift)
@:forward abstract SchemaDeclaration(SchemaDeclarationDef) from SchemaDeclarationDef to SchemaDeclarationDef{
  static public var _(default,never) = SchemaDeclarationLift;
  public function new(self) this = self;
  static public function lift(self:SchemaDeclarationDef):SchemaDeclaration return new SchemaDeclaration(self);


  static public function make(name,pack,lhs,rhs,?validation){
    return lift({
      id          : Identity.make(Ident.make(name,pack),lhs,rhs),
      validation  : validation
    });
  }
  static public function make0(name,pack,?validation){
    return make(name,pack,None,None,validation);
  }
  public function prj():SchemaDeclarationDef return this;
  private var self(get,never):SchemaDeclaration;
  private function get_self():SchemaDeclaration return lift(this);

  public function identity(){
    return this.id;
  }
  public function resolve(state:Schemata):Schema{
    state.put(this);
    return SchScalar(this); 
  }
  public function toString(){
    return identity().toString();
  }
}
class SchemaDeclarationLift{
  static public inline function to_self_constructor(self:SchemaDeclaration):GExpr{
    return throw UNIMPLEMENTED;
  }
}
