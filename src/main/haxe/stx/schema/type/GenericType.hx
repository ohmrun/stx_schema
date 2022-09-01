package stx.schema.type;

interface GenericTypeApi extends NominativeTypeApi{
  public final type : SType;
}
class GenericTypeCls extends NominativeTypeCls implements GenericTypeApi{
  public final type : SType;
  public function new(register,ident,type,?validation,?meta){
    super(register,ident,validation,meta);
    this.type     = type;
  }
  public function toString(){
    return this.identity.toString();
  }
  public function toSType():SType{
    return SType.make(STGeneric(
      Ref.make(
        Identity.make(ident,[this.type.identity]),
        () -> (this:GenericType)
      )
    ));
  }
  // public function register(state:TypeContext):SType{
  //   // var next : GenericType     = null;
  //   // var t               = Ref.make(
  //   //   () -> this.identity,
  //   //   () -> next
  //   // );
  //   // state.put(STGeneric(t));
  //   // var tI              = 
  //   //   state
  //   //     .get(this.type.identity)
  //   //     .fold(
  //   //       ok -> __.option(ok),
  //   //       () -> this.type.is_anon().if_else(
  //   //         () -> __.option(this.type.register(state)),
  //   //         () -> state.get(this.type.identity)
  //   //       )
  //   //     ).fudge(__.fault().of(E_Schema_IdentityUnresolved(this.identity)));

  //   // next = new GenericTypeCls(this.ident,tI);
  //   // return next.toSType();
  //   return throw UNIMPLEMENTED;
  // }
  override public function get_identity(){
    final result =  Identity.make(
      this.ident,
      [this.type.identity]
    );
    return result;
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

  @:noUsing static public function make(register,ident:Ident,inner,?validation,?meta){ 
    return lift(new GenericTypeCls(register,ident,inner,validation,meta));
  }
  public function copy(?register,?ident,?type,?validation,?meta){
    return make(
      __.option(register).defv(this.register),
      __.option(ident).defv(this.ident),
      __.option(type).defv(this.type),
      __.option(validation).defv(this.validation),
      __.option(meta).defv(this.meta)
    );
  }
}
class GenericTypeLift{
  
}