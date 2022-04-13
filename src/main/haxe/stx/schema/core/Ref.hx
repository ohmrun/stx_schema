package stx.schema.core;

typedef RefDef<T:Has_toStringDef> = {
  final pop: () -> T;
  final toString : () -> String;
}
@:forward abstract Ref<T:Has_toStringDef>(RefDef<T>) {
  public var value(get, never):T;
  public function get_value(){
    return this.pop();
  }
  inline function new(self) this = self;
  
  @:noUsing static public function lift<T:Has_toStringDef>(self:RefDef<T>){
    return new Ref(self);
  }
  @:noUsing static public function make<T:Has_toStringDef>(fn:() -> T){
    return lift({
        pop       : fn,
        toString  : () -> fn().toString()
      }
    );
  }
  public function toString():String return '@:[' + Std.string(this.pop())+']';
  
  @:noUsing @:from static inline public function pure<T:Has_toStringDef>(v:T):Ref<T> {
    return make(() -> v);
  }
}