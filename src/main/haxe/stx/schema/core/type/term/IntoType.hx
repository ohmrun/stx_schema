package stx.schema.core.type.term;

class IntoType extends DataTypeCls{
  static public function make(ident:Ident,debrujin:Int){
    return new IntoType(ident.name,ident.pack,debrujin);
  }
  public function new(name,pack,debrujin){
    super(name,pack);
    this.status     = TYPE_COMPLETED;
    this.debrujin   = debrujin;
  }
  public function toString(){
    return this.ident().toIdentifier().toString();
  }
  override private function get_debrujin():Null<Int>{
    return this.debrujin;
  }
  public function register(){
    Context.instance.put(this.toType());
  }
}