package stx.schema.test;

import stx.schema.Munge;
class MungeTest extends TestCase{
  static public function main(){
    __.test([new MungeTest()],[]);
  }
  public function test(){
    final identifier = Identity.make(
      Ident.make('Hello',["a","b"]),
      [
        Identity.make(
          Ident.make('Middle',["c","d"]),
          [
            Identity.make(
              Ident.make('Inner',["i","j"]),
              [
                Identity.make(Ident.make('Int',["std"]),[])
              ]
            )
          ]
        ),
        Identity.make(Ident.make('Last',["x","y"]),[])
      ]
    );
    trace(Munge.encode(identifier));
  }
}