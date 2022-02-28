package stx.schema;

using stx.Log;
using stx.Nano;
using stx.Test;
using stx.Show;

class MyRegistry extends stx.schema.Registry{
  public function apply(schemata:Schemata):Cluster<Schema>{
    // var user : Schema = SchRecord({
    //   name    : "User",
    //   fields  : [
    //     Property({
    //       name : "username",
    //       type : Schema.String()
    //     }),
    //     Property({
    //       name : "age",
    //       type : Schema.Int()
    //     }),
    //     Attribute({
    //       name      : "articles",
    //       inverse   : "author",
    //       type      : Schema.Array(schemata.ref("Article")),
    //       relation  : HAS_MANY
    //     })
    //   ]  
    // });
    // var article : Schema = SchRecord({
    //   name : "Article",
    //   fields : [
    //     Property({
    //       name      : "author",
    //       type      : Schema.Array(user)
    //     })
    //   ]
    // }); 
    //user,article
    return Cluster.lift([]);
  }
}
class Test{
  static public function main(){
    var schemata = new MyRegistry().reply();
    __.log().debug(_ -> _.show(schemata));   
  }  
}
class SchemaTest extends TestCase{

}