package stx.schema.type;

abstract class ConcreteType extends BaseTypeCls{
  public final ident : Ident;
  public function new(ident,?meta,?validation){
    this.ident = ident;
    super(meta,validation);
  }
  public function get_identity(){
    return Identity.fromIdent(this.ident);
  } 
}