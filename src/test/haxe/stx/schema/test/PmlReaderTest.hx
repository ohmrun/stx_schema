package stx.schema.test;

@stx.test.async
class PmlReaderTest extends TestCase{
  public function test(async:Async){
    final s = __.resource("journal").string();
    final r = __.pml().parser(s);
    r.environment(
      (x:ParseResult<Token,PExpr<Atom>>) -> {
        for(v in x.toUpshot().fudge()){
          trace(v);
        }
      }
    );
  }
}