package stx.schema.declare;

interface DeclareUnionSchemaApi extends DeclareNominativeSchemaApi extends WithIdentityApi{
  final rest  : Cluster<SchemaRef>;
}
class DeclareUnionSchemaCls implements DeclareUnionSchemaApi extends DeclareNominativeSchemaCls{
  public final rest  : Cluster<SchemaRef>;

  public function new(ident:Ident,rest,validation,meta){
    super(ident,validation,meta); 
    this.rest       = rest;
    
  }
  public var identity(get,null):Identity;
  public function get_identity(){ 
    return Identity.make(
      Ident.make(
        this.ident.name,
        this.ident.pack
      ),
      __.option(this.rest).defv([]).map(Identity.lift)
    );
  }
}
@:forward abstract DeclareUnionSchema(DeclareUnionSchemaApi) from DeclareUnionSchemaApi to DeclareUnionSchemaApi{
  static public var _(default,never) = DeclareUnionSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareUnionSchemaApi):DeclareUnionSchema return new DeclareUnionSchema(self);

  @:noUsing static public function make(ident:Ident,rest,?validation,?meta){
    return lift(new DeclareUnionSchemaCls(
      ident,
      rest,
      validation,
      meta
    ));
  }
  // public function resolve(state:TyperContext){
  //   // final rest = __.option(this.rest).defv([]).map(
  //   //   x -> state.get(x.identity).fold(
  //   //     x   -> SchemaRef.fromSchema(x),
  //   //     ()  -> x.resolve(state)
  //   //   )
  //   // );
  //   // final result =  make0(this.identity.name,this.identity.pack,rest,this.meta,this.validation);
  //   // state.put(SchUnion(result));
  //   // return SchUnion(result);
  //   return throw UNIMPLEMENTED;
  // }
  public function prj():DeclareUnionSchemaApi return this;
  private var self(get,never):DeclareUnionSchema;
  private function get_self():DeclareUnionSchema return lift(this);

  public function toString(){
    return this.identity.toString();
  }
} 
class DeclareUnionSchemaLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  }
  static public inline function denote(self:DeclareUnionSchema){
    // final e = __.g().expr();
    // return e.Call(
    //   e.Path('stx.schema.declare.DeclareUnionSchema.make'),
    //   [
    //     stx.schema.declare.IdentLift.denote(self.ident),
    //     e.ArrayDecl(self.rest.map(x -> x.denote()))
    //   ]
    // );
    return throw UNIMPLEMENTED;
  }
}