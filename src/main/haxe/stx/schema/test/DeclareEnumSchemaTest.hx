package stx.schema.test;

class DeclareEnumSchemaTest extends TestCase{
  public function test(){
    final e = DeclareEnumSchema.make(
      Ident.make('TestEnum',["some","pack"]),
      ['fst','snd','thd']
    );
    final ctr  = e.to_self_constructor();
    final expr = ctr.toSource();
    trace(expr);
  }
}