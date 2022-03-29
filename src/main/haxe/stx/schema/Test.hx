package stx.schema;

import stx.schema.test.*;

using stx.Log;
using stx.Nano;
using stx.Test;
using stx.Show;

class Test{
  static public function main(){
    final log = __.log().global;
          log.includes.push("**/*");

    __.test(
      [ new SchemaTest() ],
      [SchemaTest]    
    );
  }  
}