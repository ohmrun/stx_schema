package stx.schema.test;

using eu.ohmrun.Halva;
using eu.ohmrun.halva.Core;

class HalvaContextTest extends TestCase{
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
  public function test(){
    // final accretion = Accretion.pure(
    //   new Lub().toSemiGroup()
    // );
    // map_put(SchScalar(stx.schema.declare.term.SchemaBool.make()));
    // map_put(SchScalar(stx.schema.declare.term.SchemaFloat.make()));
    // map_put(SchScalar(stx.schema.declare.term.SchemaInt.make()));
    // map_put(SchScalar(stx.schema.declare.term.SchemaString.make()));
        
    // for(decl in types() ){
    //   trace(decl);
    //   //accretion.put()
    // }
  }
}

private class Lookup{
  // static public function lookup(self:Accretion<SType>,identity:Identity):Signal<LVar<SType>>{
  //   return self.redeem()
  // }
}