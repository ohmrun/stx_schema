package stx.schema.type;

class LeafType extends ScalarTypeCls{
  @:noUsing static public function make(ident,ctype,meta,?validation){
    return new LeafType(ident,ctype,meta,validation);
  }
  @:noUsing static public function make0(ident,meta,?validation){
    return new LeafType(ident,__.g().ctype().Path(p -> p.fromIdent(ident)),meta,validation);
  }
  public function new(ident,ctype,meta,?validation){
    super(ident,ctype,meta,validation);
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