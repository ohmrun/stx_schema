package stx.schema;

typedef SchemaRefDef = stx.schema.core.Identity.IdentityDef & {
  var ?pop : () -> Schema;
};

@:forward abstract SchemaRef(SchemaRefDef) from SchemaRefDef to SchemaRefDef{
  public function new(self) this = self;
  static public function lift(self:SchemaRefDef):SchemaRef return new SchemaRef(self);

  public function resolve(state:Schemata):SchemaRef{
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
            identity(),
            () -> state.get(identity()).fudge(__.fault().of(E_Schema_IdentityUnresolved(identity())))
          );
       }
     ) 
   );
  }
  public function register(state:Context):Type{
    __.log().debug('register ref: ${identity()}');
    return state.get(identity()).def(
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
            __.log().trace(_ -> _.pure(identity()));
            final val = LazyType.make(identity(),state).toType();
            state.put(val);
            return val;
          }
        );
      }
    );
  }
  static public function make(identity:Identity,?pop){
    return lift({
      name  : identity.name,
      pack  : identity.pack,
      lhs   : identity.lhs,
      rhs   : identity.rhs,
      pop   : pop
    });
  }
  static public function make0(name:String,pack:Cluster<String>,lhs:Option<Identity>,rhs:Option<Identity>,?pop){
    return make(Identity.make(Ident.make(name,pack),lhs,rhs),pop);
  }
  @:from static inline public function fromSchemaSum(self:SchemaSum){
    final that : Schema = Schema.lift(self);
    return lift({
      name  : that.name,
      pack  : that.pack,
      pop   : () -> that,
      lhs   : None,
      rhs   : None
    });
  }
  @:from static inline public function fromSchema(self:Schema){
    final identity = self.identity();
    return lift({
      name  : identity.name,
      pack  : identity.pack,
      pop   : () -> self,
      lhs   : identity.lhs,
      rhs   : identity.rhs
    });
  }
  @:from static inline public function fromIdent(self:Ident){
    return make0(self.name,self.pack,None,None);
  }
  @:from static inline public function fromIdentity(self:Identity){
    return make0(self.name,self.pack,self.lhs,self.rhs);
  }
  @:from static inline public function fromSchemaDeclaration(self:SchemaDeclarationDef){
    return fromSchemaSum(Schema.fromSchemaDeclaration(self));
  }
  public function identity(){
    return Identity.lift(this);
  }
  public function prj():SchemaRefDef return this;
  private var self(get,never):SchemaRef;
  private function get_self():SchemaRef return lift(this);

  public function toString(){
    return __.show({ name : this.name, pack : this.pack, lhs : this.lhs.map(x -> x.toString()).defv(null), rhs : this.rhs.map(x -> x.toString()).defv(null) });
  }
}