package stx.schema.core.type;

interface BaseTypeApi extends Has_toStringApi{
  public var debrujin(get,null):Null<Int>;
  private function get_debrujin():Null<Int>;

  public var validation(get,null)       : Validations;
  private function get_validation():Validations;

  public var status : TypeStatus; 

  public function identity():Identity;
  
  public function toType():Type;
  public function register(state:Context):Type;

  public function toHaxeTypePath():haxe.macro.Expr.TypePath;
}
@:using(stx.schema.core.type.BaseType.BaseTypeLift)
abstract class BaseTypeCls extends Has_toStringCls implements BaseTypeApi{
  public function new(validation){
    super();
    this.status     = TYPE_UNTOUCHED;
    this.validation = validation;
  }
  public var status : TypeStatus;
  
  public var validation(get,null) : Validations;
  private function get_validation():Validations{
    return validation;
  }
  public var debrujin(get,null)   : Null<Int>;
  private function get_debrujin():Null<Int>{
    return 1;
  }
  abstract public function toType():Type;
  abstract public function identity():Identity;
  abstract public function register(state:Context):Type;

  public function toHaxeTypePath():haxe.macro.Expr.TypePath{
    final munged                               = this.identity().toIdent_munged();
    final type_path : haxe.macro.Expr.TypePath = {
      pack : munged.pack.toArray(),
      name : munged.name
    };
    return type_path;
  }
}
class BaseTypeLift{
   
}