package stx.schema.type;

abstract class ConcreteType extends BaseTypeCls{
  public final ident : Ident;
  public function new(id,ident,?meta,?validation){
    this.ident = ident;
    super(id,meta,validation);
  }
  public function get_identity(){
    return Identity.fromIdent(this.ident);
  } 
}