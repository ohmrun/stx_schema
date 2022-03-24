package stx.schema.core.type;

import haxe.ds.StringMap;

class Context extends Clazz{
  static public var instance(get,null) : Context;
  static public function get_instance(){
    return instance == null ? instance = new Context() : instance;
  }
  final register : StringMap<Type>;
  private var index    : Int;
  
  private function new(){
    super();   
    this.register = new StringMap();
    this.index    = 0; 
  }
  public function defer(ident:Ident):Type{
    return get(ident).defv(stx.schema.core.type.term.IntoType.pure(ident).toType());
  }
  public function is_recursive(ident:Ident):Bool{
    return this.get(ident).map(
      obj -> switch(obj.data){
        case TData(t) : std.Type.getClass(t.pop()) == stx.schema.core.type.term.IntoType;
        default       : false;
      }
    ).defv(false);
  }
  public function put(type:Type){
    this.register.set(type.toString(),type);
  }
  public function next():Int{
    var n = index;
    this.index = this.index + 1;
    return n;
  }
  public function get(ident:Ident):Option<Type>{
    return __.option(register.get(ident.toIdentifier().toString()));
  }
  public function has(type:Type){
    return register.exists(type.toString());
  }
}