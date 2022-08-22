package stx.schema.test;

class TemplateTest extends TestCase{
  public function test(){

  }
  public function types(){
    final track = __.schema().record({
      name    : "Track",
      fields  : {
        properties : [
          "name" => Schema.String(),
          "year" => Schema.Int(),
        ],
        attributes : [
          "artist" => {
            relation  : HAS_MANY,
            type      : __.way().into("Artist"),
            inverse   : null
          },
          "album" => {
            relation  : HAS_MANY,
            type      : __.way().into("Album") 
          }
        ]
      }
    });
    final artist = __.schema().record({
      name    : "Artist",
      fields  : __.schema().procure({
        properties : [
          "name" => Schema.String(),
        ],
        attributes : [
          "members" => {
            type     : Schema.Null(__.way().into("Artist")),
            relation : HAS_MANY,
            inverse  : null
          }
        ]
      }) 
    });
  }
  static public function whittle(type:SType,template:Template){

  }
}
typedef Template = Signature<Identity>;