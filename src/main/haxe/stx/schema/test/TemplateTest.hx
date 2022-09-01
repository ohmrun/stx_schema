package stx.schema.test;

@stx.test.async
class TemplateTest extends TestCase{
  function src(){

  }
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
  public function test_select_one(async:Async){
    final ts  = types();
    final s   = new State(ts,new Context());
      s.reply().map(
        x -> {
          return x.search(x -> x.identity.equals(Identity.make(Ident.make('Artist',[]),[]))).fudge();
        }
      ).handle(
          (type) -> {
            for (t in type){
              // final template = select_one_scalar_typed();
              // final next     = whittle(t,template,"",s);
              // final template = select_two_scalar_typed();
              // final next     = whittle(t,template,"",s);
              //final template = select_one_object();
              //final next     = whittle(t,template,"",s);
              final template = select_one_object_object();
              final next     = whittle(t,template,"",s);
              trace(next);
            }
            async.done();
          }
      );
  }
  public function test_select_union(async:Async){
    final ts  = types();
    final s   = new State(ts,new Context());
      s.reply().map(
        x -> {
          return x.search(
            (x) -> {
              final id = 
                Identity.make(
                  Ident.make('Union',['std']),
                  [
                    Identity.make(Ident.make('Artist',[]),[]),
                    Identity.make(Ident.make('Band',[]),[])
                  ]
                );
              final ok = x.identity.equals(id);
              return ok;
            }
          ).fudge();
        }
      ).handle(
          (type) -> {
            for (t in type){
              final template = select_one_from_union();
              final next     = whittle(t,template,"",s);
              trace(next);
            }
            async.done();
          }
      );
  }
  public function types(){
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
  public function template():Template{
    final s = __.om().signature();
    return null;
  }
  //Pledge.make(__.reject(f -> f.of(E_Schema_RequireFieldsDeclaration(template))));
  static public function whittle(type:SType,template:Template,ns:String,state:State):Res<SType,SchemaFailure>{
    final e0 = (field,type) -> E_Schema_NoTemplateFieldInType(field,type);

    function get_field(type:SType,string:String):Option<Field>{
      return type.fields.search(x -> x.name == string);
    }
    function f(type:SType,template:Template,ns:String):Res<SType,SchemaFailure>{
      __.log().trace('${type}');
      function obj(template:Template,type:SType):Res<Cluster<Field>,SchemaFailure>{
        return switch(template){
          case Cons(PLabel(s),Cons(PGroup(g),rest)) : 
            switch(type.data){
              case STAnon(_) | STRecord(_) : 
                get_field(type,s).fold(
                  ok -> f(ok.type,g,ns).flat_map(
                    type -> __.accept([Field.make(s,type)].imm())
                  ),
                  () -> __.reject(f -> f.of(e0(s,type)))
                ).flat_map(
                  (fields) -> obj(rest,type).map(arr -> fields.concat(arr))
                );
              default : __.reject(f -> f.of(e0(s,type)));
            }
          case Cons(PLabel(s),rest)                 : 
            __.log().trace('${type.data}');
            switch(type.data){
              case STMono | STScalar(_) | STEnum(_) : 
                __.accept([Field.make(s,type)]);
              case STAnon(_) | STRecord(_) : 
                get_field(type,s).fold(
                  ok -> __.accept([ok].imm()),
                  () -> __.reject(f -> f.of(e0(s,type)))
                ).flat_map(
                  (fields) -> obj(rest,type).map(arr -> fields.concat(arr))
                );
              default : __.reject(f -> f.of(e0(s,type)));
            }
          case Nil:
            __.accept([]);
          default : 
            __.log().trace('${template}');
            __.reject(f -> f.of(E_Schema_Dynamic("encountered error state")));
        }
      }
      function step(template:Template,type:SType):Res<Option<SType>,SchemaFailure>{
        return switch(type.data){
          case STScalar(_) |  STAnon(_) | STRecord(_)     : 
            obj(template,type).map(
              fields -> Some(AnonType.make(state.context.create(),fields).toSType())
            );
          case STEnum(_) : 
            __.accept(Some(type));
          case STGeneric(t)     :
            f(t.pop().type,template,ns).map(
              type -> Some(t.pop().copy(state.context.create(),null/** TODO name **/,type).toSType())
            );
          case STUnion(t)       :
            Res.bind_fold(
              t.pop().rest,
              (n:SType,m:Cluster<SType>) -> {
                return step(template,n).map(
                  opt -> opt.fold(
                    m.snoc,
                    () -> m
                  )
                );
              },
              []
            ).adjust(
              (types) -> types.is_defined().if_else(
                () -> __.accept(Some(t.pop().copy(state.context.create(),types).toSType())),
                () -> __.reject(f -> f.of(E_Schema_Dynamic("no candidates")))
              )
            );
          case STLink(t)        :
            __.log().trace('link: $template');
            f(t.pop().into,template,ns).flat_map(
                type -> {
                  return __.accept(Some(switch(t.pop().relation){
                    case HAS_MANY : SType.Array(state.context.create(),type);
                    default       : type;
                  }));
                }
          );
          case STLazy(f)        : step(template,f.pop().type);
          case STMono           : __.accept(None);
        }
      }
      return step(template,type).adjust(
        opt -> opt.fold(
          ok -> __.accept(ok),
          () -> __.reject(f -> f.of(E_Schema_Dynamic("foobar")))
        )
      );
    }
    return f(type,template,ns);
  }
  public function select_one_scalar_typed():Template{
    return Cons(PLabel('name'),Nil);
  }
  public function select_two_scalar_typed():Template{
    return Cons(PLabel('name'),Cons(PLabel('real_name'),Nil));
  }
  public function select_one_object(){
    return Cons(PLabel('tracks'),Cons(PGroup(Cons(PLabel('name'),Nil)),Nil));
  }
  public function select_one_object_and_one_field(){
    return Cons(PLabel('tracks'),Cons(PGroup(Cons(PLabel('name'),Nil)),Cons(PLabel('name'),Nil)));
  }
  public function select_one_object_object(){
    return Cons(PLabel('tracks'),Cons(PGroup(Cons(PLabel('album'),Cons(PGroup(Cons(PLabel('year'),Cons(PLabel('name'),Nil))),Nil))),Nil));
  }
  public function select_one_from_union(){
    return Cons(PLabel('name'),Nil);
  } 
}

