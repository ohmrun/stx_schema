package stx.schema.core;

interface RefApi<T> extends WithIdentityApi{
  public function pop():T;
}
class RefCls<T> implements RefApi<T>{
  public function pop(){
    return getter();
  }
  public var identity(get,null)      : Identity; 
  public function get_identity(){
    return this.identity;
  }
  final getter      : Void -> T;

  public function new(identity,getter){
    this.identity = identity;
    this.getter   = getter;  
  }
  public function toString(){
    return this.identity.toString();
  }
}
class RefWrap<T:WithIdentityApi> implements RefApi<T>{
  final value : T;
  public function new(value){
    this.value = value;
  }
  public function pop(){
    return value;
  }
  public var identity(get,null):Identity;
  public function get_identity(){
    return value.identity;
  }
}
@:forward abstract Ref<T>(RefApi<T>) from RefApi<T> to RefApi<T>{
  public var value(get, never):T;
  public function get_value(){
    return this.pop();
  }
  inline function new(self) this = self;
  
  @:noUsing static public function lift<T>(self:RefApi<T>){
    return new Ref(self);
  }
  @:noUsing static public function make<T>(identity:Identity,getter:() -> T):Ref<T>{
    return lift(new RefCls(identity,getter));
  }
  @:noUsing static public function wrap<T:WithIdentityApi>(self:T):Ref<T>{
    return lift(new RefWrap(self));
  }
  // @:noUsing static public function wait<T,E>(identity:Identity,self:Pledge<T,E>):Pledge<Ref<T>>{
  //   return self.map(
  //     (x) -> {
  //       return make(identity,() -> x);
  //     }
  //   );
  // }
  public function toString():String return '@:[' + Std.string(this.identity)+']';
}