package stx.schema.declare;

interface DeclareNominativeSchemaApi extends DeclareSchemaApi{
  public final ident : Ident;
}
abstract class DeclareNominativeSchemaCls extends DeclareSchemaCls implements DeclareNominativeSchemaApi{
  public function new(ident,?validation,?meta){
    super(validation,meta);
    this.ident = ident;
  }
  public final ident : Ident;
  public function toString(){
    return this.ident.toIdentifier().toString();
  }
}