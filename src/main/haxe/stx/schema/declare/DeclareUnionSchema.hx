package stx.schema.declare;

interface DeclareUnionSchemaApi extends DeclareSchemaApi{
  final ident : Ident;
  final rest  : Cluster<SchemaRef>;
}
class DeclareUnionSchemaCls implements DeclareUnionSchemaApi extends DeclareSchemaCls{
  public final rest  : Cluster<SchemaRef>;
  public final ident : Ident;

  public function new(ident:Ident,rest,meta,validation){
    super(meta); 
    this.ident      = ident;
    this.rest       = rest;
    this.validation = validation;
  }
  public function get_id(){ 
    return Identity.make(
      Ident.make(
        this.ident.name,
        this.ident.pack
      ),
      __.option(this.rest).defv([]).map(Identity.lift)
    );
  }
  public function get_validation(){ return this.validation; }  
}
@:forward abstract DeclareUnionSchema(DeclareUnionSchemaApi) from DeclareUnionSchemaApi to DeclareUnionSchemaApi{
  static public var _(default,never) = DeclareUnionSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareUnionSchemaApi):DeclareUnionSchema return new DeclareUnionSchema(self);

  @:noUsing static public function make(ident:Ident,rest,?meta,?validation){
    return lift(new DeclareUnionSchemaCls(
      ident,
      rest,
      __.option(meta).defv(PEmpty),
      _.validation.concat(__.option(validation).defv(Cluster.unit()))
    ));
  }
  @:noUsing static public function make0(name,pack,rest,?meta,?validation){
    return make(
      Ident.make(name,pack),
      rest,
      meta,
      validation
    );
  }
  public function resolve(state:TyperContext){
    final rest = __.option(this.rest).defv([]).map(
      x -> state.get(x.id).fold(
        x   -> SchemaRef.fromSchema(x),
        ()  -> x.resolve(state)
      )
    );
    final result =  make0(this.id.name,this.id.pack,rest,this.meta,this.validation);
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
  static public inline function denote(self:DeclareUnionSchema){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.declare.DeclareUnionSchema.make'),
      [
        stx.schema.declare.IdentLift.denote(self.ident),
        e.ArrayDecl(self.rest.map(x -> x.denote()))
      ]
    );
  }
}