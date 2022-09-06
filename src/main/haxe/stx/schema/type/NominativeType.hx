package stx.schema.type;

interface NominativeTypeApi extends BaseTypeApi{
  public final ident : Ident;
}
abstract class NominativeTypeCls extends BaseTypeCls implements NominativeTypeApi{
  public final ident : Ident;
  public function new(ident,?validation,?meta){
    super(validation,meta);
    this.ident = ident;
  }
  public function get_identity(){
    return Identity.fromIdent(this.ident);
  } 
}