package stx.schema.core;

typedef RefDef<T>     = {
  final pop         : () -> T;
  final getIdentity : () -> Identity; 
}
@:forward abstract Ref<T>(RefDef<T>) {
  public var value(get, never):T;
  public function get_value(){
    return this.pop();
  }
  inline function new(self) this = self;
  
  @:noUsing static public function lift<T>(self:RefDef<T>){
    return new Ref(self);
  }
  @:noUsing static public function make<T>(getIdentity:()->Identity,fn:() -> T){
    return lift({
        pop          : fn,
        getIdentity  : getIdentity
      }
    );
  }
  public function toString():String return '@:[' + Std.string(this.getIdentity())+']';
}