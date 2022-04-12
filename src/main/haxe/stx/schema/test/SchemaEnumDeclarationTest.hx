package stx.schema.test;

class SchemaEnumDeclarationTest extends TestCase{
  public function test(){
    final e = SchemaEnumDeclaration.make(
      Ident.make('TestEnum',["some","pack"]),
      ['fst','snd','thd']
    );
    final ctr  = e.to_self_constructor();
    final expr = ctr.toSource();
    trace(expr);
  }
}