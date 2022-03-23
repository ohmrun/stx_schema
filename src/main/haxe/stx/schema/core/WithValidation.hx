package stx.schema.core;

class WithValidation extends Clazz{
  public function new(validation){
    super();
    this.validation = validation;
  }
  final validation : Validations;
}