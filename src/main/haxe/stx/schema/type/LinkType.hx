package stx.schema.type;

interface LinkTypeApi extends BaseTypeApi{
  public final into      : SType;
  public final relation  : RelationType;
  public final inverse   : String;
}
class LinkTypeCls extends BaseTypeCls implements LinkTypeApi{
  public final into      : SType;
  public final relation  : RelationType;
  public final inverse   : String;

  public function new(into,relation,inverse,?meta,?validation){
    super(meta,validation);
    this.into       = into;
    this.relation   = relation;
    this.inverse    = inverse;
    this.validation = validation;
  }
  public function toSType():SType{
    return STLink(Ref.make(() -> this.identity,() -> (this:LinkType)));
  }
  public function toString(){
    return '$relation $into $inverse';
  }
  public function register(state:TypeContext):SType{
    var next : LinkType     = null;
    var t                   = Ref.make(
      () -> this.identity,
      function():LinkType{
        final inner = state.get(this.into.identity).def(() -> this.into.register(state));
        var tI              = 
          state
            .get(this.into.identity)
            .fold(
              ok -> __.option(ok),
              () -> this.into.is_anon().if_else(//TODO: this shouldn't be a thing
                () -> __.option(state.get(this.into.identity).def(() ->this.into.register(state))),
                () -> __.option(null)
              )
            ).fudge(__.fault().of(E_Schema_IdentityUnresolved(this.identity)));
        return new LinkTypeCls(tI,relation,inverse);
      }
    );
    
    return STLink(t);
  }
  public function get_identity(){
    final ident = Ident.make('${this.relation}',['link']);
    return Identity.make(
      ident,
      __.option(this.into.identity),
      None
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

  @:noUsing static public function make(into,relation,inverse,?meta,?validation){ 
    return lift(new LinkTypeCls(into,relation,inverse,meta,validation));
  }
}
class LinkTypeLift{
  
  static public function leaf(self:LinkType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
  static public function main(self:LinkType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
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
  // static public function getLeafComplexType(self:LinkType):GComplexType{
  //   return switch(self.relation){
  //     case HAS_MANY : new TypeArray(new TypeID()).getLeafComplexType(); 
  //     default       : __.g().ctype().fromString('stx.schema.ID');
  //   }
  // }
  // static public function getMainComplexType(self:LinkType):GComplexType{
  //   return switch(self.relation){
  //     case HAS_MANY : new TypeArray(self.into).getLeafComplexType(); 
  //     default       : self.into.getLeafComplexType();
  //   }
  // }
}