package stx.schema.declare;

interface DeclareSchemaApi extends WithValidationApi{
  public final meta          : PExpr<Primitive>;
  public var id(get,null)    : stx.schema.core.Identity;
  public function get_id():Identity;
}
abstract class DeclareSchemaCls implements DeclareSchemaApi extends WithValidationCls{
  public function new(meta){
    super();
    this.meta = meta;
  }
  public final meta          : PExpr<Primitive>;
  public var id(get,null)    : stx.schema.core.Identity;
  abstract public function get_id():Identity;
}
class DeclareSchemaBase extends DeclareSchemaCls{
  public function new(id,meta,?validation){
    this.id         = id;
    this.validation = validation;
    super(meta);
  }
  public function get_id(){ return this.id; }
  public function get_validation(){ return this.validation; }  
}
abstract class DeclareSchemaConcrete extends DeclareSchemaCls{
  public final ident : Ident;
  public function new(ident,meta){
    this.ident = ident;
    super(meta);
  }
  public function get_id(){
    return Identity.fromIdent(ident);
  }
}
@:using(stx.schema.declare.DeclareSchema.DeclareSchemaLift)
@:forward abstract DeclareSchema(DeclareSchemaApi) from DeclareSchemaApi to DeclareSchemaApi{
  static public var _(default,never) = DeclareSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareSchemaApi):DeclareSchema return new DeclareSchema(self);


  @:noUsing static public function make(name,pack,lhs,rhs,?meta,?validation){
    return lift(new DeclareSchemaBase(
      Identity.make(Ident.make(name,pack),lhs,rhs),
      __.option(meta).defv(Empty),
      validation
    ));
  }
  @:noUsing static public function make0(name,pack,?meta,?validation){
    return make(name,pack,None,None,meta,validation);
  }
  public function prj():DeclareSchemaApi return this;
  private var self(get,never):DeclareSchema;
  private function get_self():DeclareSchema return lift(this);

  
  public function toString(){
    return this.id.toString();
  }
}
class DeclareSchemaLift{
  static public inline function denote(self:DeclareSchema):GExpr{
    return throw UNIMPLEMENTED;
  }
}
