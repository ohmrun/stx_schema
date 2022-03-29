package stx.schema;

class SchemataCls{
  public final register  : StringMap<Schema>;
  public final context   : Context; 

  public function new(?register,?context){
    this.register = __.option(register).def(
      () -> {
        final map = new StringMap();
        final put = (schema:Schema)->{
          map.set(schema.identity().toString(),schema);
        }
        put(new stx.schema.term.SchemaBool());
        out(new stx.schema.term.SchemaFloat());
        out(new stx.schema.term.SchemaInt());
        out(new stx.schema.term.SchemaString());
      }
    );
    this.context  = __.option(context).defv(@:privateAccess new Context());
  }
  public function get(key:Identity):Option<Schema>{
    return __.option(this.register.get(key.toString()));
  }
  public function put(data:Schema){
    this.register.set(data.identity().toString(),data);
  }
  public function type(){
    for(type in this.register){
      __.log().debug(_ -> _.thunk(() -> type.toString()));
      type.resolve(this);
    }
    trace("HERE");
    return this;
  }
  public function toString(){
    return Iter.lift(register).map(x -> x.toString()).toArray().join(",");
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
