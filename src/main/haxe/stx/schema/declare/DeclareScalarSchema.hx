package stx.schema.declare;

//TODO consider narrowing ctype
interface DeclareScalarSchemaApi extends DeclareNominativeSchemaApi extends WithIdentityApi{
  public final ctype:GComplexType;
}
class DeclareScalarSchemaCls implements DeclareScalarSchemaApi extends DeclareNominativeSchemaCls{
  public final ctype:GComplexType;
  public function new(ident,?ctype,?validation,?meta){
    super(ident,validation,meta);
    this.ctype = __.option(ctype).defv(__.g().ctype().Path(p -> p.fromIdent(ident)));
  }
  public var identity(get,null):Identity;
  public function get_identity(){
    return Identity.make(this.ident,[]);
  }
}
@:forward abstract DeclareScalarSchema(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  public function new(self) this = self;
  static public function lift(self:DeclareScalarSchemaApi):DeclareScalarSchema return new DeclareScalarSchema(self);
  @:noUsing static public function make(ident,ctype,?validation,?meta){
    return lift(new DeclareScalarSchemaCls(ident,ctype,validation,meta));
  }
  public function toString(){
    return this.identity.toString();
  }
  public function prj():DeclareScalarSchemaApi return this;
  private var self(get,never):DeclareScalarSchema;
  private function get_self():DeclareScalarSchema return lift(this);
}