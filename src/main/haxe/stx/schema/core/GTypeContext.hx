package stx.schema.core;

class GTypeContext extends Clazz{
  static public var _(default,never) = GTypeContextLift;
  public final context      : TypeContext;
  public final definitions  : StringMap<GTypeDefinition>;
  public final show         : haxe.macro.Printer; 

  public function new(context){
    super();
    this.context      = context;
    this.definitions  = new StringMap();
    this.show         = new haxe.macro.Printer();
  }
  // public function has(def:HTypeDefinition){
  //   return definitions.exists(identity.toString());
  // }
  // public function put(def:HTypeDefinition){
  //   this.set(def.)
  // }
  public function toString(){
    return 'GTypeContext';
  }
}
class GTypeContextLift{
  
}