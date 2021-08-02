package stx.schema;

abstract class Registry extends Clazz{
  public function reply(){
    return apply(Schemata.unit());
  }
  abstract public function apply(map:Schemata):Cluster<Schema>;
}