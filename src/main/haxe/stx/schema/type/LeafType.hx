package stx.schema.type;

class LeafType extends NativeTypeCls{
  @:noUsing static public function make(ident,ctype,?validation,?meta){
    return new LeafType(ident,ctype,validation,meta);
  }
  @:noUsing static public function make0(ident,?validation,?meta){
    return new LeafType(ident,__.g().ctype().Path(p -> p.fromIdent(ident)),validation,meta);
  }
  public function new(ident,ctype,?validation,?meta){
    super(ident,ctype,validation,meta);
    this.status = TYPE_COMPLETED;
  }
  public function toString(){
    return this.identity.toString();
  }
} 