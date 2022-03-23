package stx.schema.core.type.term;

abstract class LeafType extends DataTypeCls{
  public function new(name,pack){
    super(name,pack);
  }
  public function toString(){
    return this.ident().toIdentifier().toString();
  }
  override private function get_debrujin():Null<Int>{
    if(this.debrujin == null){
      if(Context.instance.has(this.toType())){
        for(type in Context.instance.get(this.ident())){
          this.debrujin = type.debrujin;
        }
        return this.debrujin;
      }else{
        this.debrujin = Context.instance.next();
        Context.instance.put(this.toType());
        return this.debrujin;
      }
    }else{
      return this.debrujin;
    } 
  }
}