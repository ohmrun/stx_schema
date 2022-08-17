package stx.schema.type;

class LeafType extends ScalarTypeCls{
  @:noUsing static public function make(register,ident,ctype,?validation,?meta){
    return new LeafType(register,ident,ctype,validation,meta);
  }
  @:noUsing static public function make0(register,ident,?validation,?meta){
    return new LeafType(register,ident,__.g().ctype().Path(p -> p.fromIdent(ident)),validation,meta);
  }
  public function new(register,ident,ctype,?validation,?meta){
    super(register,ident,ctype,validation,meta);
    this.status = TYPE_COMPLETED;
  }
  public function toString(){
    return this.identity.toString();
  }
  public function get_identity(){
    return Identity.fromIdent(this.ident);
  }
} 