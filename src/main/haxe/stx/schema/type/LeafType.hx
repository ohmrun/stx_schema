package stx.schema.type;

class LeafType extends DataTypeCls{
  @:noUsing static public function make(ident,?meta,?validation){
    return new LeafType(ident);
  }
  public final ident : Ident;
  public function new(ident,?meta,?validation){
    super(meta,validation);
    this.ident  = ident;
    this.status = TYPE_COMPLETED;
  }
  public function toString(){
    return this.identity.toString();
  }
  public function register(state:TypeContext){
    state.put(this.toSType());
    return this.toSType();
  }
  public function get_identity(){
    return Identity.fromIdent(this.ident);
  }
} 