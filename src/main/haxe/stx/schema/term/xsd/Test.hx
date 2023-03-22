package stx.schema.term.xsd;

import stx.schema.Test;
//import stx.schema.term.Dtd;
using stx.Log;
using stx.Test;

class Test{
  static public function tests(){
    return [
      new stx.schema.term.xsd.test.XsdTest()
    ];
  }
  static public function main(){
    final log = __.log().global;
    __.test().auto();
  }
}

