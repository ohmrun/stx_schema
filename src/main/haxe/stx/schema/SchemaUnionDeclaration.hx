package stx.schema;

typedef SchemaUnionDeclarationDef = SchemaDeclarationDef & {
  final lhs : SchemaRef;
  final rhs : SchemaRef;
}
@:forward abstract SchemaUnionDeclaration(SchemaUnionDeclarationDef) from SchemaUnionDeclarationDef to SchemaUnionDeclarationDef{
  static public var _(default,never) = SchemaUnionDeclarationLift;
  public function new(self) this = self;
  static public function lift(self:SchemaUnionDeclarationDef):SchemaUnionDeclaration return new SchemaUnionDeclaration(self);

  static public function make(ident:Ident,lhs,rhs,?validation){
    return lift({
      id            : Identity.fromIdent(ident),
      lhs           : lhs,
      rhs           : rhs,
      validation    : _.validation.concat(__.option(validation).defv(Cluster.unit()))
    });
  }
  static public function make0(name,pack,lhs,rhs,?validation){
    return make(
      Ident.make(name,pack),
      lhs,
      rhs,
      validation
    );
  }
  public function identity(){
    return Identity.make(
      Ident.make(
        this.id.name,
        this.id.pack
      ),
      Some(Identity.lift(this.lhs)),
      Some(Identity.lift(this.rhs))
    );
  }
  public function resolve(state:Schemata){
    var l = state.get(this.lhs.identity()).fold(
      x   -> SchemaRef.fromSchema(x),
      ()  -> this.lhs.resolve(state)
    );
    var r = state.get(this.rhs.identity()).fold(
      x   -> SchemaRef.fromSchema(x),
      ()  -> this.lhs.resolve(state)
    );
    final result =  make0(this.id.name,this.id.pack,l,r,this.validation);
    state.put(SchUnion(result));
    return SchUnion(result);
  }
  public function prj():SchemaUnionDeclarationDef return this;
  private var self(get,never):SchemaUnionDeclaration;
  private function get_self():SchemaUnionDeclaration return lift(this);

  public function toString(){
    return identity().toString();
  }
} 
class SchemaUnionDeclarationLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  }
  static public inline function to_self_constructor(self:SchemaUnionDeclaration){
    return throw UNIMPLEMENTED;
  }
}