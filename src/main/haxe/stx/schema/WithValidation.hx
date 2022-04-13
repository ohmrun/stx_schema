package stx.schema;

interface WithValidationApi{
  public var validation(get,null) : Validations;
  private function get_validation():Validations;
}
abstract class WithValidationCls extends Clazz implements WithValidationApi{
  public function new(){
    super();
  }
  public var validation(get,null) : Validations;
  abstract private function get_validation():Validations;
}