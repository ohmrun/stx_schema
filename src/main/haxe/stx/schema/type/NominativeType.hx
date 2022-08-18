package stx.schema.type;

interface NominativeTypeApi extends BaseTypeApi{
  public final ident : Ident;
}
abstract class NominativeTypeCls extends BaseTypeCls implements NominativeTypeApi{
  public final ident : Ident;
  public function new(register,ident,?validation,?meta){
    super(register,validation,meta);
    this.ident = ident;
  }
  public function get_identity(){
    return Identity.fromIdent(this.ident);
  } 
}