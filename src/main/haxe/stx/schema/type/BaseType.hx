package stx.schema.type;

interface BaseTypeApi extends Has_getIdentityApi{
  public var validation(get,null):Validations;
  private function get_validation():Validations;

  public var meta   : PExpr<Primitive>;

  public var identity(get,null):Identity;
  public function get_identity():Identity;
  
  public function toSType():SType;
  public function register(state:TypeContext):SType;

  public function toGTypePath():GTypePath;

  public function toBaseTypeApi():BaseTypeApi;
}
@:using(stx.schema.type.BaseType.BaseTypeLift)
abstract class BaseTypeCls extends Has_getIdentityCls implements BaseTypeApi{

  public function new(meta,validation){
    super();
    this.meta       = __.option(meta).defv(PEmpty);
    this.validation = validation;
  }
  public var meta   : PExpr<Primitive>;
  public var status : TypeStatus;
  
  public var validation(get,null) : Validations;
  private function get_validation():Validations{
    return validation;
  }
  public var identity(get,null):Identity;
  abstract public function get_identity():Identity;

  public function getIdentity(){
    return this.identity;
  }
  abstract public function toSType():SType;
  abstract public function register(state:TypeContext):SType;

  public function toGTypePath():GTypePath{
    final munged                               = this.identity.toIdent_munged();
    return __.g().type_path().Make(munged.name,munged.pack.toArray());
  }
  public function toBaseTypeApi():BaseTypeApi{
    return this;
  }
}
class BaseTypeLift{
   
}