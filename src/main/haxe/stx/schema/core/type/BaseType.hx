package stx.schema.core.type;

interface BaseTypeApi extends Has_toStringApi{
  public var debrujin(get,null):Null<Int>;
  private function get_debrujin():Null<Int>;

  public var validation(get,null)       : Validations;
  private function get_validation():Validations;
}
abstract class BaseTypeCls extends Has_toStringCls implements BaseTypeApi{
  public function new(){
    super();
  }
  public var validation(get,null) : Validations;
  private function get_validation():Validations{
    return Cluster.unit();
  }
  public var debrujin(get,null)   : Null<Int>;
  private function get_debrujin():Null<Int>{
    return if(this.debrujin == null){
      this.debrujin = Context.instance.next();
      Context.instance.put(this.toType());
      this.debrujin;
    }else{
      this.debrujin;
    }
  }
  abstract function toType():Type;
}