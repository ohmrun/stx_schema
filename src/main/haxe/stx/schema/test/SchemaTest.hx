package stx.schema.test;

import stx.schema.Core;

class SchemaTest extends TestCase{
  public function _test_property_declaration(){
    final _       = __.schema();
    trace("OK");
    final thing   = _.record({
      name : "thing",
      fields : {
        properties : [
          "name" => Schema.String()
        ] 
      }
    });    
    trace("OK2");
    trace(thing);
  }
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
  public function test_this(){
    var types = TyperContext.make(types());
        types.type();
    var context  = types.context;
    var register = @:privateAccess context.register;  
    var context  = new GTypeContext(context);
    //stx.schema.view.Main.apply(context);
  }
  public function test(){
    is_true(true);
  }
  #if macro
  public function test_make_gtypes(){
    var types = TyperContext.make(types());
        types.type();
    trace(types);
  }
  #end
}