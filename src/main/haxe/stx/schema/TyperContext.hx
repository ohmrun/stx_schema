package stx.schema;

class TyperContextCls{
  public var namespace    : Way;
  public final schemas    : StringMap<Schema>;
  public final context    : TypeContext; 

  public function new(?schemas,?context,?namespace){
    this.schemas = __.option(schemas).def(
      () -> {
        final map = new StringMap();
        final map_put = (schema:Schema)->{
          map.set(schema.id.toString(),schema);
        }
        map_put(SchScalar(stx.schema.declare.term.SchemaBool.make()));
        map_put(SchScalar(stx.schema.declare.term.SchemaFloat.make()));
        map_put(SchScalar(stx.schema.declare.term.SchemaInt.make()));
        map_put(SchScalar(stx.schema.declare.term.SchemaString.make()));

        return map;
      }
    );
    this.context    = __.option(context).defv(@:privateAccess new TypeContext());
    this.namespace  = __.option(namespace).defv(Way.unit());
  }
  static public function make(schemas,context,namespace){
    return new TyperContextCls(schemas,context,namespace);
  }
  static public function make0(?schemas,?context,?namespace){
    return make(schemas,context,namespace);
  }
  public function get(key:Identity):Option<Schema>{
    return __.option(this.schemas.get(key.toString()));
  }
  public function put(data:Schema){
    this.schemas.set(data.id.toString(),data);
  }
  public function type(){
    for(type in this.schemas){
      __.log().debug(_ -> _.thunk(() -> type.toString()));
      type.resolve(this);
    }
    __.log().trace(_ -> _.pure(context));
    for(schema in this.schemas){
      __.log().debug(schema.id.toString());
      try{
        schema.register(this.context);
      }catch(e:haxe.Exception){
        __.log().error(e.message);
        __.log().error(_ -> _.pure(e.stack));
        throw(e);
      }      
    }
    __.log().debug("done");
    __.log().debug(_ -> _.pure(this.context.register.toString()));
    return this;
  }
  public function toString(){
    return Iter.lift(schemas).map(x -> x.toString()).toArray().join(",");
  }
  public function with_namespace(fn:Way->Way){
    return make(this.schemas,this.context,fn(this.namespace));
  }
}
@:forward abstract TyperContext(TyperContextCls) from TyperContextCls to TyperContextCls {
  public function new(self) this = self;
  @:noUsing static public function make(?schemas:Cluster<Schema>){
    var self = unit();
    for(schema in schemas){
      self.put(schema);
    }
    return self;
  }
  @:noUsing static public function lift(self:TyperContextCls):TyperContext return new TyperContext(self);
  static public function unit(){
    return lift(new TyperContextCls());
  }
  public function prj():TyperContextCls return this;
  private var self(get,never):TyperContext;
  private function get_self():TyperContext return lift(this);
}
