package stx.schema;

typedef SchemaRefDef = stx.schema.core.Identity.IdentityDef & {
  //used for turning schemas into types
  var ?pop : () -> Schema;
};

@:using(stx.schema.SchemaRef.SchemaRefLift)
@:forward abstract SchemaRef(SchemaRefDef) from SchemaRefDef to SchemaRefDef{
  static public var _(default,never) = SchemaRefLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:SchemaRefDef):SchemaRef return new SchemaRef(self);

  public function resolve(state:TyperContext):SchemaRef{
    __.log().debug('resolve ref');
   return state.get(Identity.lift(this)).fold(
     x  -> fromSchema(x),
     () -> __.that().exists().apply(this.pop).is_ok().if_else(
       () -> {
         final val  = this.pop();
         final next = val.resolve(state);
         state.put(next);
         return fromSchema(next);
       },
       () -> {
          return make(
            identity,
            () -> state.get(identity).fudge(__.fault().of(E_Schema_IdentityUnresolved(identity)))
          );
       }
     ) 
   );
  }
  public function register(state:TypeContext):SType{
    __.log().debug('register ref: ${identity}');
    return state.get(identity).def(
      () -> {
        __.log().trace(_ -> _.pure(this.pop));
        return __.option(this.pop).fold(
          ok -> {
            __.log().trace('pulling');
            final schema = ok();
            __.log().debug('$schema');
            schema.register(state);
          },
          () -> {
            __.log().trace(_ -> _.pure(identity ));
            final val = LazyType.make(identity,state).toSType();
            state.put(val);
            return val;
          }
        );
      }
    );
  }
  @:noUsing static public function make(identity:Identity,?pop){
    return lift({
      name  : identity.name,
      pack  : identity.pack,
      rest  : identity.rest,
      pop   : pop
    });
  }
  @:noUsing static public function make0(name:String,pack:Cluster<String>,rest:Cluster<Identity>,?pop){
    return make(Identity.make(Ident.make(name,pack),rest),pop);
  }
  @:from static inline public function fromSchemaSum(self:SchemaSum){
    final that : Schema = Schema.lift(self);
    return lift({
      name  : that.identity.name,
      pack  : that.identity.pack,
      pop   : () -> that,
      rest  : that.identity.rest
    });
  }
  @:from static inline public function fromSchema(self:Schema){
    final identity = self.identity;
    return lift({
      name  : identity.name,
      pack  : identity.pack,
      pop   : () -> self,
      rest  : identity.rest
    });
  }
  @:from static public inline function fromString(self:String){
    final parts = self.split(".");
    final name  = parts.pop();
    return fromIdent(Ident.make(name,parts)); 
  }
  @:from static inline public function fromIdent(self:Ident){
    return make0(self.name,self.pack,[]);
  }
  @:from static inline public function fromIdentity(self:Identity){
    return make0(self.name,self.pack,self.rest);
  }
  @:from static inline public function fromDeclareScalarSchema(self:DeclareScalarSchemaApi){
    return fromSchemaSum(Schema.fromDeclareScalarSchema(self));
  }
  public var identity(get,never) : Identity;
  public function get_identity(){
    return Identity.make(
      Ident.make(this.name,this.pack),
      this.rest
    );
  }
  public function prj():SchemaRefDef return this;
  private var self(get,never):SchemaRef;
  private function get_self():SchemaRef return lift(this);

  public function toString(){
    return __.show({ name : this.name, pack : this.pack, rest : this.rest.map(x -> x.toString())});
  }
}
class SchemaRefLift{
  static public function denote(self:SchemaRef):GExpr{
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.SchemaRef.make'),
      [
        Identity._.denote({
          name  : self.name,
          pack  : self.pack,
          rest  : self.rest
        })
      ]
    );
  }
}