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
            id,
            () -> state.get(id).fudge(__.fault().of(E_Schema_IdentityUnresolved(id)))
          );
       }
     ) 
   );
  }
  public function register(state:TypeContext):SType{
    __.log().debug('register ref: ${id}');
    return state.get(id).def(
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
            __.log().trace(_ -> _.pure(id));
            final val = LazyType.make(id,state).toSType();
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
      lhs   : identity.lhs,
      rhs   : identity.rhs,
      pop   : pop
    });
  }
  @:noUsing static public function make0(name:String,pack:Cluster<String>,lhs:Option<Identity>,rhs:Option<Identity>,?pop){
    return make(Identity.make(Ident.make(name,pack),lhs,rhs),pop);
  }
  @:from static inline public function fromSchemaSum(self:SchemaSum){
    final that : Schema = Schema.lift(self);
    return lift({
      name  : that.id.name,
      pack  : that.id.pack,
      pop   : () -> that,
      lhs   : that.id.lhs,
      rhs   : that.id.rhs
    });
  }
  @:from static inline public function fromSchema(self:Schema){
    final identity = self.id;
    return lift({
      name  : identity.name,
      pack  : identity.pack,
      pop   : () -> self,
      lhs   : identity.lhs,
      rhs   : identity.rhs
    });
  }
  @:from static public inline function fromString(self:String){
    final parts = self.split(".");
    final name  = parts.pop();
    return fromIdent(Ident.make(name,parts)); 
  }
  @:from static inline public function fromIdent(self:Ident){
    return make0(self.name,self.pack,None,None);
  }
  @:from static inline public function fromIdentity(self:Identity){
    return make0(self.name,self.pack,self.lhs,self.rhs);
  }
  @:from static inline public function fromDeclareScalarSchema(self:DeclareScalarSchemaApi){
    return fromSchemaSum(Schema.fromDeclareScalarSchema(self));
  }
  public var id(get,never) : Identity;
  public function get_id(){
    return Identity.make(
      Ident.make(this.name,this.pack),
      this.lhs,
      this.rhs
    );
  }
  public function prj():SchemaRefDef return this;
  private var self(get,never):SchemaRef;
  private function get_self():SchemaRef return lift(this);

  public function toString(){
    return __.show({ name : this.name, pack : this.pack, lhs : this.lhs.map(x -> x.toString()).defv(null), rhs : this.rhs.map(x -> x.toString()).defv(null) });
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
          lhs   : self.lhs,
          rhs   : self.rhs  
        })
      ]
    );
  }
}