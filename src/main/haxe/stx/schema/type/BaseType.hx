package stx.schema.type;

interface BaseTypeApi extends WithIdentityApi{
  final register:Register;

  public var validation(get,null):Validations;
  private function get_validation():Validations;

  public var meta   : PExpr<Primitive>;

  public function toSType():SType;
  public function toGTypePath():GTypePath;
  public function toBaseTypeApi():BaseTypeApi;
}
@:using(stx.schema.type.BaseType.BaseTypeLift)
abstract class BaseTypeCls extends WithIdentityCls implements BaseTypeApi{

  public function new(register,?validation,?meta){
    this.register   = register;
    this.validation = __.option(validation).defv(Validations.unit());
    this.meta       = __.option(meta).defv(PEmpty);
  }
  public final register   : Register;
  public var meta         : PExpr<Primitive>;
  public var status       : TypeStatus;
  
  public var validation(get,null) : Validations;
  private function get_validation():Validations{
    return validation;
  }
  abstract public function toSType():SType;
  //abstract public function register(state:TypeContext):SType;

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