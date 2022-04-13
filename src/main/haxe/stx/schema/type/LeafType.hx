package stx.schema.type;

class LeafType extends DataTypeCls{
  @:noUsing static public function make(name,pack,?validation){
    return new LeafType(name,pack);
  }
  public function new(name,pack,?validation){
    super(name,pack == null ? [] : pack,validation);
    this.status = TYPE_COMPLETED;
  }
  public function toString(){
    return this.identity().toString();
  }
  public function register(state:TypeContext){
    state.put(this.toSType());
    return this.toSType();
  }
} 