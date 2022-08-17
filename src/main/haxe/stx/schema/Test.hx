package stx.schema;

#if macro
  import stx.schema.view.Leaf;
#end
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
      new stx.schema.test.RegisterTest()
    ];
  }
  static public function main(){
    final log = __.log().global;
          log.includes.push("**/*");

    
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