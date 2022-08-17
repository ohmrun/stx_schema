package stx.schema;

interface WithValidationApi{
  public var validation(get,null) : Validations;
  private function get_validation():Validations;
}
abstract class WithValidationCls extends Clazz implements WithValidationApi{
  public function new(validation){
    this.validation = validation;
    super();
  }
  public var validation(get,null) : Validations;
  private function get_validation():Validations{
    return this.validation;
  }
}