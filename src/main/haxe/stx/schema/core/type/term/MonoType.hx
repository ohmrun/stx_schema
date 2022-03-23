package stx.schema.core.type.term;

class MonoType extends DataTypeCls{
  public function new(){
    super("TMono",[]);
    this.status     = TYPE_COMPLETED;
  }
  public function toString(){
    return "TMono";
  }
  override private function get_debrujin():Null<Int>{
    return -1;
  }
  public function register(){
    Context.instance.put(this.toType());
  }
}