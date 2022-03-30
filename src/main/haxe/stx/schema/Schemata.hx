package stx.schema;

class SchemataCls{
  public final schemas    : StringMap<Schema>;
  public final context    : Context; 

  public function new(?schemas,?context){
    this.schemas = __.option(schemas).def(
      () -> {
        final map = new StringMap();
        final map_put = (schema:Schema)->{
          map.set(schema.identity().toString(),schema);
        }
        map_put(SchScalar(stx.schema.term.SchemaBool.make()));
        map_put(SchScalar(stx.schema.term.SchemaFloat.make()));
        map_put(SchScalar(stx.schema.term.SchemaInt.make()));
        map_put(SchScalar(stx.schema.term.SchemaString.make()));

        return map;
      }
    );
    this.context  = __.option(context).defv(@:privateAccess new Context());
  }
  public function get(key:Identity):Option<Schema>{
    return __.option(this.schemas.get(key.toString()));
  }
  public function put(data:Schema){
    this.schemas.set(data.identity().toString(),data);
  }
  public function type(){
    for(type in this.schemas){
      __.log().debug(_ -> _.thunk(() -> type.toString()));
      type.resolve(this);
    }
    trace(context);
    for(schema in this.schemas){
      __.log().debug(schema.identity().toString());
      try{
        schema.register(this.context);
      }catch(e:haxe.Exception){
        trace(e.message);
        trace(e.stack);
        throw(e);
      }      
    }
    __.log().debug("done");
    return this;
  }
  public function toString(){
    return Iter.lift(schemas).map(x -> x.toString()).toArray().join(",");
  }
}
@:forward abstract Schemata(SchemataCls) from SchemataCls to SchemataCls {
  public function new(self) this = self;
  static public function make(schemas:Cluster<Schema>){
    var self = unit();
    for(schema in schemas){
      self.put(schema);
    }
    return self;
  }
  static public function lift(self:SchemataCls):Schemata return new Schemata(self);
  static public function unit(){
    return lift(new SchemataCls());
  }
  public function prj():SchemataCls return this;
  private var self(get,never):Schemata;
  private function get_self():Schemata return lift(this);
}
