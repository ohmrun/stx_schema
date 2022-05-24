package stx.schema.declare;

interface DeclareScalarSchemaApi extends DeclareSchemaApi{
  public final ctype:GComplexType;
}
class DeclareScalarSchemaCls implements DeclareScalarSchemaApi extends DeclareSchemaBase{
  public final ctype:GComplexType;
  public function new(id,ctype,meta,validation){
    super(id,meta,validation);
    this.ctype = ctype;
  }
}
@:forward abstract DeclareScalarSchema(DeclareScalarSchemaApi) from DeclareScalarSchemaApi to DeclareScalarSchemaApi{
  public function new(self) this = self;
  static public function lift(self:DeclareScalarSchemaApi):DeclareScalarSchema return new DeclareScalarSchema(self);
  @:noUsing static public function make(id,ctype,meta,?validation){
    return lift(new DeclareScalarSchemaCls(id,ctype,meta,validation));
  }
  public function resolve(state:TyperContext):Schema{
    state.put(this);
    return SchScalar(this); 
  } 
  public function toString(){
    return this.identity.toString();
  }
  public function prj():DeclareScalarSchemaApi return this;
  private var self(get,never):DeclareScalarSchema;
  private function get_self():DeclareScalarSchema return lift(this);
}