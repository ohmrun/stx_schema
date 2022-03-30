package stx.schema.core.type;

interface GenericTypeApi extends DataTypeApi{
  public final type : Type;
}
class GenericTypeCls extends DataTypeCls implements GenericTypeApi{
  public final type : Type;
  public function new(name,pack,type,?validation){
    super(name,pack,validation);
    this.type = type;
  }
  public function toString(){
    return identity().toString();
  }
  override public function toType():Type{
    return Type.make(TGeneric(Ref.pure((this:GenericType))));
  }
  public function register(state:Context):Type{
    var next : GenericType     = null;
    var t               = Ref.make(
      () -> next
    );
    state.put(TGeneric(t));
    var tI              = 
      state
        .get(this.type.identity())
        .fold(
          ok -> __.option(ok),
          () -> this.type.is_anon().if_else(
            () -> __.option(this.type.register(state)),
            () -> __.option(null)
          )
        ).fudge(__.fault().of(E_Schema_IdentityUnresolved(this.identity())));

    next = new GenericTypeCls(this.name,this.pack,tI);
    return next.toType();
  }
  override public function identity(){
    final ident = Ident.make(name,pack);
    return Identity.make(
      ident,
      __.option(this.type.identity()),
      None
    );
  }
}
@:forward abstract GenericType(GenericTypeApi) from GenericTypeApi to GenericTypeApi{
  public function new(self) this = self;
  static public function lift(self:GenericTypeApi):GenericType return new GenericType(self);

  public function prj():GenericTypeApi return this;
  private var self(get,never):GenericType;
  private function get_self():GenericType return lift(this);

  @:noUsing static public function make(name,pack,inner,?validation){ 
    return lift(new GenericTypeCls(name,pack,inner,validation));
  }
}