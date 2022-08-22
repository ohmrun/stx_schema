package stx.schema.test;

class TemplateTest extends TestCase{
  @stx.test.async
  public function test(async:Async){
    final ts  = types();
    final s   = new State(ts,new Context());
    try{
      s.reply().handle(
        x -> {
          trace(x);
          for(ok in x){
            for(v in ok){
              trace(v.fields);
            }
          }
          async.done();
        }
      );
    }catch(e){
      trace(e.stack);
      async.done();
    }
  }
  public function types(){
    final artist_or_band = __.schema().union(
      Ident.make("ArtistOrBand"),
      ['Artist','Band'].map(x -> SchemaRef.fromIdent(Ident.make(x)))
    );
    final track = __.schema().record({
      name    : "Track",
      fields  : {
        properties : [
          "name" => Schema.String()
        ],
        attributes : [
          "artist" => __.schema().attribute(
            artist_or_band.identity,
            HAS_MANY
          ),
          "album" => __.schema().attribute(
            Schema.Null(__.way().into("Album").toSchemaRef()),
            HAS_MANY
          )
        ]
      }
    });
    final artist = __.schema().record({
      name    : "Artist",
      fields  : {
        properties : [
          "name" => Schema.String(),
        ]
      } 
    });
    final band = __.schema().record({
      name : "Band",
      fields : {
        properties : [
          "name" => Schema.String(),
        ],
        attributes : [
          "members" => __.schema().attribute(
            Schema.Null(SchemaRef.fromIdent(__.way().into("Artist"))),
            HAS_MANY
          )
        ]
      }
    });
    final album = __.schema().record({
      name : "Album",
      fields : {
        properties : [
          "name" => Schema.String(),
          "year" => Schema.Int(),
        ],
        attributes : [
          "artist" => __.schema().attribute(
            artist_or_band.identity,
            HAS_ONE
          ),
          "tracks" => __.schema().attribute(
            __.way().into("Track"),
            HAS_MANY
          ),
          "record_label" => __.schema().attribute(
            __.way().into("RecordLabel"),
            HAS_ONE
          )
        ]
      }
    });
    final album_type = __.schema().enumeration(
      Ident.make("AlbumType"),
      ["single,ep,album"]
    );
    final record_label = __.schema().record({
      name : "RecordLabel",
      fields : {
        "properties" : [
          "name" => Schema.String()
        ],
        "attributes" : [
          "contracts" => __.schema().attribute(__.way().into("RecordContract").toSchemaRef(),HAS_MANY)
        ]
      }  
    });
    final record_contracts = __.schema().record({
      name : "RecordContract",
      fields : {
        properties : [
          "start" => Schema.Date(),
          "end"   => Schema.Date(),
        ],
        attributes : [
          "artist"        => __.schema().attribute(artist_or_band.identity,HAS_ONE),
          "record_label"  => __.schema().attribute(__.way().into("RecordLabel").toSchemaRef(),HAS_ONE)
        ]
      }
    });
    return [track,artist,band,artist_or_band,album,album_type,record_label,record_contracts];
  }
  static public function whittle(type:SType,template:Template){

  }
}
typedef Template = Signature<Identity>;