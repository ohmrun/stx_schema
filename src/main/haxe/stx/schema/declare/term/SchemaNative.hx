package stx.schema.declare.term;

class SchemaNative extends DeclareNativeSchemaCls{
  public function new(ident:Ident,?validation,?meta){
    super(
      ident,
      __.glot().Expr.GComplexType.Path(p -> p.fromIdent(ident)),
      validation,
      meta
    );
  }
  static public function make(ident:Ident,?validation,?meta){
    return new SchemaNative(ident,validation,meta);
  }
}