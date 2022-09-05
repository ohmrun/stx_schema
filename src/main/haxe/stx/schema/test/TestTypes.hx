package stx.schema.test;

class TestTypes{
  public static function one(){
    final _       = __.schema();
    final user    = _.record({
      name   : "User",
      fields : ({
        properties : [
          "username" => Schema.String(),
          "age"      => Schema.Int()
        ],
        attributes : [
          "articles" => {
            inverse   : "author",
            type      : __.way().into("Article"),
            relation  : HAS_MANY,
            meta      : PEmpty
          },
          "key" => {
            inverse   : null,
            type      : __.way().into("Key"),
            relation  : HAS_ONE,
            meta      : PEmpty
          }
        ]
      }:Procurements)
    });
    final article   = _.record({
      name    : "Article",
      fields  : ({
        "properties" : [
          "title" => Schema.String()
        ],
        "attributes" : [
          "author" => {
            inverse   : "article",
            type      : __.way().into("User"),
            relation  : HAS_ONE,
            meta      : PEmpty
          }
        ]
      }:Procurements)
    });
    final key = _.record({
      name : "Key",
      fields : {
        properties : [
          "value" => Schema.String()
        ] 
      }
    });
    final states       = _.enumeration(Ident.make('States',['human']),['awake','sleepy','asleep','hungry','horny','dead']);
    return [user,article,states,key];
  }
  static public function two(){
    final artist_or_band = __.schema().union(
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
          "name"      => Schema.String(),
          "real_name" => Schema.String()
        ],
        attributes : [
          "tracks" => __.schema().attribute(
            __.way().into("Track"),
            HAS_MANY,
            'artist'//TODO lensing through ArtistOrBand?
          ),
          "albums" => __.schema().attribute(
            __.way().into("Album"),
            HAS_MANY,
            'artist'//TODO lensing through ArtistOrBand?
          ),
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
}