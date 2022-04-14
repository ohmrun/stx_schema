package stx.schema.type;

interface GenericTypeApi extends DataTypeApi{
  public final type : SType;
}
class GenericTypeCls extends ConcreteType implements GenericTypeApi{
  public final type : SType;
  public function new(ident,type,?meta,?validation){
    super(ident,meta,validation);
    this.type     = type;
  }
  public function toString(){
    return this.identity.toString();
  }
public function toSType():SType{
    return SType.make(STGeneric(Ref.pure((this:GenericType))));
  }
  public function register(state:TypeContext):SType{
    var next : GenericType     = null;
    var t               = Ref.make(
      () -> next
    );
    state.put(STGeneric(t));
    var tI              = 
      state
        .get(this.type.identity)
        .fold(
          ok -> __.option(ok),
          () -> this.type.is_anon().if_else(
            () -> __.option(this.type.register(state)),
            () -> __.option(null)
          )
        ).fudge(__.fault().of(E_Schema_IdentityUnresolved(this.identity)));

    next = new GenericTypeCls(this.ident,tI);
    return next.toSType();
  }
  override public function get_identity(){
    return Identity.make(
      this.ident,
      __.option(this.type.identity),
      None
    );
  }
}
@:using(stx.schema.type.GenericType.GenericTypeLift)
@:forward abstract GenericType(GenericTypeApi) from GenericTypeApi to GenericTypeApi{
  static public var _(default,never) = GenericTypeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:GenericTypeApi):GenericType return new GenericType(self);

  public function prj():GenericTypeApi return this;
  private var self(get,never):GenericType;
  private function get_self():GenericType return lift(this);

  @:noUsing static public function make(ident:Ident,inner,?meta,?validation){ 
    return lift(new GenericTypeCls(ident,inner,meta,validation));
  }
}
class GenericTypeLift{
  static public function main(self:GenericType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
  static public function leaf(self:GenericType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
}