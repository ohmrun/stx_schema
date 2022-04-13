package stx.schema.declare;

typedef DeclareSchemaDef = stx.schema.WithValidationDef & {
  final id : stx.schema.core.Identity;
}

@:using(stx.schema.declare.DeclareSchema.DeclareSchemaLift)
@:forward abstract DeclareSchema(DeclareSchemaDef) from DeclareSchemaDef to DeclareSchemaDef{
  static public var _(default,never) = DeclareSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareSchemaDef):DeclareSchema return new DeclareSchema(self);


  @:noUsing static public function make(name,pack,lhs,rhs,?validation){
    return lift({
      id          : Identity.make(Ident.make(name,pack),lhs,rhs),
      validation  : validation
    });
  }
  @:noUsing static public function make0(name,pack,?validation){
    return make(name,pack,None,None,validation);
  }
  public function prj():DeclareSchemaDef return this;
  private var self(get,never):DeclareSchema;
  private function get_self():DeclareSchema return lift(this);

  public function identity(){
    return this.id;
  }
  public function resolve(state:TyperContext):Schema{
    state.put(this);
    return SchScalar(this); 
  }
  public function toString(){
    return identity().toString();
  }
}
class DeclareSchemaLift{
  static public inline function to_self_constructor(self:DeclareSchema):GExpr{
    return throw UNIMPLEMENTED;
  }
}
