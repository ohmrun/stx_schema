package stx.schema.declare;

interface DeclareGenericSchemaApi extends DeclareSchemaApi{
  final type  : SchemaRef;
  final ident : Ident;
}
class DeclareGenericSchemaCls implements DeclareGenericSchemaApi extends DeclareSchemaConcrete{
  public final type : SchemaRef;
  public function new(ident,type,meta,?validation){
    this.type       = type;
    this.validation = validation;
    super(ident,meta);
  }
  override public function get_id(){ 
    return Identity.make(
      Ident.make(
        this.ident.name,
        this.ident.pack
      ),
      Some(Identity.lift(this.type)),
      None
    );
  }
  public function get_validation(){ return this.validation; }
} 
@:forward abstract DeclareGenericSchema(DeclareGenericSchemaApi) from DeclareGenericSchemaApi to DeclareGenericSchemaApi{
  static public var _(default,never) = DeclareGenericSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareGenericSchemaApi):DeclareGenericSchema return new DeclareGenericSchema(self);

  //Identity.make(Ident.make(name,pack),Some(type.id),None)
  @:noUsing static public function make(ident:Ident,type:SchemaRef,?meta:PExpr<Primitive>,?validation:Validations):DeclareGenericSchema{
    return lift(new DeclareGenericSchemaCls(
      ident,
      type,
      __.option(meta).defv(Empty),
      _.validation.concat(__.option(validation).defv(Cluster.unit()))
    ));
  }
  @:noUsing static public function make0(name,pack,type:SchemaRef,?meta:PExpr<Primitive>,?validation:Validations):DeclareGenericSchema{
    return lift(new DeclareGenericSchemaCls(
      Ident.make(name,pack),
      type,
      __.option(meta).defv(Empty),
      _.validation.concat(__.option(validation).defv(Cluster.unit()))
    ));
  }
  public function resolve(state:TyperContext){
    final typeI   = state.get(this.type.id).map(SchemaRef.fromSchema).def(
      () -> this.type.resolve(state)
    );
    final result  = SchGeneric(make0(this.id.name,this.id.pack,typeI,this.validation));
    state.put(result);
    return result; 
  }
  public function prj():DeclareGenericSchemaApi return this;
  private var self(get,never):DeclareGenericSchema;
  private function get_self():DeclareGenericSchema return lift(this);

  @:to public function toSchema():Schema{
    return SchGeneric(this);
  }
  public function toString(){
    final thiz = this.id.toString();
    return thiz;
  }
} 
class DeclareGenericSchemaLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  } 
  static public function to_self_constructor(self:DeclareGenericSchema){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.declare.DeclareGenericSchema.make'),
      [
        e.Const( c -> c.String(self.id.name)),
        e.ArrayDecl(
          __.option(self.id.pack).defv([]).prj().map(
            str -> e.Const(
              c -> c.String(str)
            )
          )
        ),
        SchemaRef._.to_self_constructor(self.type)
      ]
    );
  }
}