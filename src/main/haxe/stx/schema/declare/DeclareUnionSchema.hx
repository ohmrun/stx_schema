package stx.schema.declare;

interface DeclareUnionSchemaApi extends DeclareSchemaApi{
  final lhs : SchemaRef;
  final rhs : SchemaRef;
}
class DeclareUnionSchemaCls implements DeclareUnionSchemaApi extends DeclareSchemaCls{
  public final lhs   : SchemaRef;
  public final rhs   : SchemaRef;
  final ident : Ident;

  public function new(ident:Ident,lhs,rhs,meta,validation){
    super(meta); 
    this.ident      = ident;
    this.lhs        = lhs;
    this.rhs        = rhs;
    this.validation = validation;
  }
  public function get_id(){ 
    return Identity.make(
      Ident.make(
        this.ident.name,
        this.ident.pack
      ),
      Some(Identity.lift(this.lhs)),
      Some(Identity.lift(this.rhs))
    );
  }
  public function get_validation(){ return this.validation; }  
}
@:forward abstract DeclareUnionSchema(DeclareUnionSchemaApi) from DeclareUnionSchemaApi to DeclareUnionSchemaApi{
  static public var _(default,never) = DeclareUnionSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareUnionSchemaApi):DeclareUnionSchema return new DeclareUnionSchema(self);

  @:noUsing static public function make(ident:Ident,lhs,rhs,?meta,?validation){
    return lift(new DeclareUnionSchemaCls(
      ident,
      lhs,
      rhs,
      __.option(meta).defv(Empty),
      _.validation.concat(__.option(validation).defv(Cluster.unit()))
    ));
  }
  @:noUsing static public function make0(name,pack,lhs,rhs,?meta,?validation){
    return make(
      Ident.make(name,pack),
      lhs,
      rhs,
      meta,
      validation
    );
  }
  public function resolve(state:TyperContext){
    var l = state.get(this.lhs.id).fold(
      x   -> SchemaRef.fromSchema(x),
      ()  -> this.lhs.resolve(state)
    );
    var r = state.get(this.rhs.id).fold(
      x   -> SchemaRef.fromSchema(x),
      ()  -> this.lhs.resolve(state)
    );
    final result =  make0(this.id.name,this.id.pack,l,r,this.meta,this.validation);
    state.put(SchUnion(result));
    return SchUnion(result);
  }
  public function prj():DeclareUnionSchemaApi return this;
  private var self(get,never):DeclareUnionSchema;
  private function get_self():DeclareUnionSchema return lift(this);

  public function toString(){
    return this.id.toString();
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