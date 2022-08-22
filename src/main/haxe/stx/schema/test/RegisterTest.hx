package stx.schema.test;

class RegisterTest extends TestCase{
  public function types(){
    final _       = __.schema();
    final user    = _.record({
      name   : "User",
      fields : {
        properties : [
          "username" => Schema.String(),
          "age"      => Schema.Int()
        ],
        attributes : [
          "article" => {
            inverse   : "author",
            type      : __.way().into("Article"),
            relation  : HAS_MANY
          }
        ]
      }
    });
    final article   = _.record({
      name    : "Article",
      fields  : {
        "properties" : [
          "title" => Schema.String()
        ],
        "attributes" : [
          "author" => {
            inverse   : "article",
            type      : __.way().into("User"),
            relation  : HAS_MANY,
            meta      : PEmpty
          }
        ]
      }
    });
    return [user,article];
  }
  @stx.test.async
  public function test(async:Async){
    trace("start");
    try{
      final ts  = types();
      final s   = new State(ts,new Context());
      s.reply().handle(
        x -> {
          for(ok in x){
            for(v in ok){
              trace(v);
            }
          }
          async.done();
        }
      );
    }catch(e:haxe.Exception){
      trace(e.details());
      trace(e.stack);
    }
  }
}