package stx.schema;

import stx.schema.test.*;

using stx.Log;
using stx.Nano;
using stx.Test;
using stx.Show;

class Test{
  static public function tests(){
    return [
      new SchemaTest(),
      new stx.schema.test.ComparisonTest(),
      new stx.schema.test.RegisterTest(),
      new stx.schema.test.TemplateTest(),
    ];
  }
  static public function main(){
    final log = __.log().global;
          //log.includes.push("stx/schema");
          //log.level = TRACE;

    #if boot
      boot();
    #else
      __.test().auto();
    #end
  }  
  private static macro function boot(){
    final log = __.log().global;
    //log.includes.push("**/*");
    __.test().run(
      [
        // new SchemaTest() ,
        //new DeclareEnumSchemaTest(),
      ],
      []    
    );
    return macro {};
  }
}