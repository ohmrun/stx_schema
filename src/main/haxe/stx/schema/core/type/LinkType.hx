package stx.schema.core.type;

interface LinkTypeApi extends BaseTypeApi{
  public final into      : Type;
  public final relation  : SchemaRelationSum;
  public final inverse   : String;
}
class LinkTypeCls extends BaseTypeCls implements LinkTypeApi{
  public final into      : Type;
  public final relation  : SchemaRelationSum;
  public final inverse   : String;

  public function new(into,relation,inverse,?validation){
    super(validation);
    this.into       = into;
    this.relation   = relation;
    this.inverse    = inverse;
    this.validation = validation;
  }
  public function toType():Type{
    return TLink(Ref.pure((this:LinkType)));
  }
  public function toString(){
    return '$relation $into $inverse';
  }
  public function register(state:Context):Type{
    var next : LinkType     = null;
    var t                   = Ref.make(
      function():LinkType{
        final inner = state.get(this.into.identity()).def(() -> this.into.register(state));
        var tI              = 
          state
            .get(this.into.identity())
            .fold(
              ok -> __.option(ok),
              () -> this.into.is_anon().if_else(//TODO: this shouldn't be a thing
                () -> __.option(state.get(this.into.identity()).def(() ->this.into.register(state))),
                () -> __.option(null)
              )
            ).fudge(__.fault().of(E_Schema_IdentityUnresolved(this.identity())));
        return new LinkTypeCls(tI,relation,inverse);
      }
    );
    
    return TLink(t);
  }
  public function identity(){
    final ident = Ident.make('Link',['std']);
    return Identity.make(
      ident,
      __.option(this.into.identity()),
      None
    );
  }
}
@:forward abstract LinkType(LinkTypeApi) from LinkTypeApi to LinkTypeApi{
  public function new(self) this = self;
  static public function lift(self:LinkTypeApi):LinkType return new LinkType(self);

  public function prj():LinkTypeApi return this;
  private var self(get,never):LinkType;
  private function get_self():LinkType return lift(this);

  @:noUsing static public function make(into,relation,inverse,?validation){ 
    return lift(new LinkTypeCls(into,relation,inverse,validation));
  }
}