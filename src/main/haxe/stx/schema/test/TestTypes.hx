package stx.schema.test;

class TestTypes{
  public static function one(){
    final _       = __.schema();
    final user    = _.record({
      name   : "User",
      fields : {
        properties : [
          "username" => Schema.String(),
          "age"      => Schema.Int()
        ],
        attributes : [
          "articles" => {
            inverse   : "author",
            type      : __.way().into("Article"),
            relation  : HAS_MANY
          },
          "key" => {
            type : __.way().into("Key"),
            relation : HAS_ONE
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
            relation  : HAS_ONE
          }
        ]
      }
    });
    final key = _.record({
      name : "Key",
      fields : {
        properties : [
          "value" => Schema.String()
        ] 
      }
    });
    final states       = _.enumeration('States',['human'],['awake','sleepy','asleep','hungry','horny','dead']);
    return [user,article,states,key];
  }
}