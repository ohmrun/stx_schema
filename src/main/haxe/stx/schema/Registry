package stx.schema;

abstract class Registry extends Clazz{
  public function reply(){
    return apply(TyperContext.unit());
  }
  abstract public function apply(map:TyperContext):Cluster<Schema>;
}