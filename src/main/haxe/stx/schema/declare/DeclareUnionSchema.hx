package stx.schema.declare;

typedef DeclareUnionSchemaDef = DeclareSchemaDef & {
  final lhs : SchemaRef;
  final rhs : SchemaRef;
}
@:forward abstract DeclareUnionSchema(DeclareUnionSchemaDef) from DeclareUnionSchemaDef to DeclareUnionSchemaDef{
  static public var _(default,never) = DeclareUnionSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareUnionSchemaDef):DeclareUnionSchema return new DeclareUnionSchema(self);

  @:noUsing static public function make(ident:Ident,lhs,rhs,?validation){
    return lift({
      id            : Identity.fromIdent(ident),
      lhs           : lhs,
      rhs           : rhs,
      validation    : _.validation.concat(__.option(validation).defv(Cluster.unit()))
    });
  }
  @:noUsing static public function make0(name,pack,lhs,rhs,?validation){
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
  public function resolve(state:TyperContext){
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
  public function prj():DeclareUnionSchemaDef return this;
  private var self(get,never):DeclareUnionSchema;
  private function get_self():DeclareUnionSchema return lift(this);

  public function toString(){
    return identity().toString();
  }
} 
class DeclareUnionSchemaLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  }
  //TODO
  static public inline function to_self_constructor(self:DeclareUnionSchema){
    final e = __.g().expr();
    return 
    return throw UNIMPLEMENTED;
  }
}