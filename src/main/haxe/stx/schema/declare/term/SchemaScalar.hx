package stx.schema.declare.term;

class SchemaScalar extends DeclareScalarSchemaCls{
  public function new(ident:Ident,?validation,?meta){
    super(
      Identity.fromIdent(ident),
      __.g().ctype().Path(p -> p.fromIdent(ident)),
      validation,
      meta
    );
  }
  static public function make(ident:Ident,?validation,?meta){
    return new SchemaScalar(ident,validation,meta);
  }
}