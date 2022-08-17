package stx.schema.type;

interface LinkTypeApi extends BaseTypeApi{
  public final into      : SType;
  public final relation  : RelationType;
  public final inverse   : Null<String>;
}
class LinkTypeCls extends BaseTypeCls implements LinkTypeApi{
  public final into      : SType;
  public final relation  : RelationType;
  public final inverse   : Null<String>;

  public function new(register,into,relation,?inverse,?validation,?meta){
    super(register,validation,meta);
    this.into       = into;
    this.relation   = relation;
    this.inverse    = inverse;
    this.validation = validation;
  }
  public function toSType():SType{
    return STLink(Ref.wrap((this:LinkType)));
  }
  public function toString(){
    return '$relation $into $inverse';
  }
  // public function register(state:TypeContext):SType{
  //   // var next : LinkType     = null;
  //   // var t                   = Ref.make(
  //   //   () -> this.identity,
  //   //   function():LinkType{
  //   //     final inner = state.get(this.into.identity).def(() -> this.into.register(state));
  //   //     var tI              = 
  //   //       state
  //   //         .get(this.into.identity)
  //   //         .fold(
  //   //           ok -> __.option(ok),
  //   //           () -> this.into.is_anon().if_else(//TODO: this shouldn't be a thing
  //   //             () -> __.option(state.get(this.into.identity).def(() ->this.into.register(state))),
  //   //             () -> __.option(null)
  //   //           )
  //   //         ).fudge(__.fault().of(E_Schema_IdentityUnresolved(this.identity)));
  //   //     return new LinkTypeCls(tI,relation,inverse);
  //   //   }
  //   // );
    
  //   // return STLink(t);
  //   return throw UNIMPLEMENTED;
  // }
  public function get_identity(){
    final ident   = Ident.make('${this.relation}',['link']);
    final reverse = __.option(this.inverse).map(x -> Ident.make(x)).map(x -> []).defv([]);
    return Identity.make(
      ident,
      [this.into.identity].concat(reverse)
    );
  }
}
@:using(stx.schema.type.LinkType.LinkTypeLift)
@:forward abstract LinkType(LinkTypeApi) from LinkTypeApi to LinkTypeApi{
  public function new(self) this = self;
  @:noUsing static public function lift(self:LinkTypeApi):LinkType return new LinkType(self);

  public function prj():LinkTypeApi return this;
  private var self(get,never):LinkType;
  private function get_self():LinkType return lift(this);

  @:noUsing static public function make(register,into,relation,inverse,?validation,?meta){ 
    return lift(new LinkTypeCls(register,into,relation,inverse,validation,meta));
  }
}
class LinkTypeLift{
  static public function lookup(self:LinkType):Option<SType>{
    return self.into.fields.search(
      kv -> {
        __.log().debug('${self.inverse} ${kv.name}');
        return self.inverse == kv.name;
      }
    ).map(
      x -> x.type
    );
  }
}