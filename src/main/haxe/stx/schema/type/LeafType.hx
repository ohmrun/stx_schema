package stx.schema.type;

class LeafType extends ScalarTypeCls{
  @:noUsing static public function make(id,ident,ctype,meta,?validation){
    return new LeafType(id,ident,ctype,meta,validation);
  }
  @:noUsing static public function make0(id,ident,meta,?validation){
    return new LeafType(id,ident,__.g().ctype().Path(p -> p.fromIdent(ident)),meta,validation);
  }
  public function new(id,ident,ctype,meta,?validation){
    super(id,ident,ctype,meta,validation);
    this.ident  = ident;
    this.status = TYPE_COMPLETED;
  }
  public function toString(){
    return this.identity.toString();
  }
  // public function register(state:TypeContext){
  //   state.put(this.toSType());
  //   return this.toSType();
  // }
  public function get_identity(){
    return Identity.fromIdent(this.ident);
  }
} 