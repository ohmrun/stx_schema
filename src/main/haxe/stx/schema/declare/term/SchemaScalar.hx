package stx.schema.declare.term;

class SchemaScalar extends DeclareScalarSchemaCls{
  public function new(ident:Ident,meta,?validation){
    super(
      Identity.fromIdent(ident),
      __.g().ctype().Path(p -> p.fromIdent(ident)),
      meta,
     validation
     );
  }
  static public function make(ident:Ident,meta,?validation){
    return new SchemaScalar(ident,meta,validation);
  }
  static public function make0(name:String,pack:Way,meta,?validation){
    final ident = Ident.make(name,pack);
    return make(ident,meta,validation);
  }
}