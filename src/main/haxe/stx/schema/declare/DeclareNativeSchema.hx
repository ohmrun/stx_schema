package stx.schema.declare;

//TODO consider narrowing ctype
interface DeclareNativeSchemaApi extends DeclareNominativeSchemaApi extends WithIdentityApi{
  public final ctype:GComplexType;
}
class DeclareNativeSchemaCls implements DeclareNativeSchemaApi extends DeclareNominativeSchemaCls{
  public final ctype:GComplexType;
  public function new(ident,?ctype,?validation,?meta){
    super(ident,validation,meta);
    this.ctype = __.option(ctype).defv(__.glot().ctype().Path(p -> p.fromIdent(ident)));
  }
  public var identity(get,null):Identity;
  public function get_identity(){
    return Identity.make(this.ident,[]);
  }
}
@:forward abstract DeclareNativeSchema(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  public function new(self) this = self;
  static public function lift(self:DeclareNativeSchemaApi):DeclareNativeSchema return new DeclareNativeSchema(self);
  @:noUsing static public function make(ident,ctype,?validation,?meta){
    return lift(new DeclareNativeSchemaCls(ident,ctype,validation,meta));
  }
  public function toString(){
    return this.identity.toString();
  }
  public function prj():DeclareNativeSchemaApi return this;
  private var self(get,never):DeclareNativeSchema;
  private function get_self():DeclareNativeSchema return lift(this);
}