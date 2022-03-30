package stx.schema.core;

class Context extends Clazz{
  static public function make(){
    return new Context();
  }
  // static public var instance(get,null) : Context;
  // static public function get_instance(){
  //   return instance == null ? instance = new Context() : instance;
  // }
  final register : StringMap<Type>;
//  final trigger  : SignalTrigger<Type>;
  
  private var index    : Int;
  
  private function new(){
    super();   
    this.register = new StringMap();
    this.put(new stx.schema.core.type.term.TypeBool().toType());
    this.put(new stx.schema.core.type.term.TypeFloat().toType());
    this.put(new stx.schema.core.type.term.TypeInt().toType());
    this.put(new stx.schema.core.type.term.TypeString().toType());
  //  this.trigger  = Signal.trigger();
    this.index    = 0; 
  }
  public function put(type:Type){
    this.register.set(type.identity().toString(),type);
  }
  public function next():Int{
    var n = index;
    this.index = this.index + 1;
    return n;
  }
  public function get(identity:Identity):Option<Type>{
    __.log().trace(identity.toString());
    return __.option(register.get(identity.toString()));
  }
  public function has(type:Type){
    return register.exists(type.toString());
  }
  static public function unit(){
    return new Context();    
  }
  public function toString(){
    return Iter.lift(this.register).map(
      x -> x.toString()
    ).toArray().join(",");
  }
}