package stx.schema;

class GTypeContext extends Clazz{
  static public var _(default,never) = GTypeContextLift;
  public final context      : TypeContext;
  public final definitions  : StringMap<Option<GTypeDefinition>>;
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
  public function mark(id:Identity){
    this.definitions.set(id.toString(),None);
  }
  public function put(def:GTypeDefinition){
    this.definitions.set(Identity.fromIdent(def.ident()).toString(),Some(def));
  }
  public function get(id:Identity){
    return __.option(this.definitions.get(id.toString())).flat_map(x -> x);
  }
  public function has(id:Identity){
    return switch(this.definitions.get(id.toString())){
      case Some(_)  : true;
      case None     : true;
      case null     : false; 
    }
  }
  public function toString(){
    return 'GTypeContext:($definitions)';
  }
}
class GTypeContextLift{
  
}