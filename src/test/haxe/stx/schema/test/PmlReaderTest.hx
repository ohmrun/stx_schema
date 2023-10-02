package stx.schema.test;

@stx.test.async
class PmlReaderTest extends TestCase{
  public function test(async:Async){
    final s = __.resource("journal").string();
    final r = __.pml().parser()(s.reader());
    for(v in r.toUpshot().fudge()){
      trace(v);
    }
  }
}