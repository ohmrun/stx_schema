package stx.schema.type;

@:using(stx.schema.type.LazyType.LazyTypeLift)
class LazyType extends BaseTypeCls{
  public var type(get,null) :Null<SType>;
  public final lookup : Identity;

  public function get_type():Null<SType>{
    //throw "here";
    return ctx();
  }
  private final ctx : () -> Null<SType>;
  
  public function new(id,lookup,ctx,?validation,?metas){
    super(validation,metas);
    this.lookup = lookup;
    this.ctx    = ctx;
  }
  private function get_type_option(){
    return type == null ? None : Some(type);
  }
  override function get_validation():Validations{
    return get_type_option().map((x:SType) -> x.validation).defv([].imm());
  }
  // public function register(state:TypeContext){
  //   //state.put(this.StoSType());
  //   return this.toSType();
  // }
  public function toSType():SType{
    return STLazy(
      Ref.make(
        lookup,
        () -> this
      )
    );
  }
  public function toString(){
    return identity.toString();
  }
  @:noUsing static public function make(id,context,ctx){
    return new LazyType(id,context,ctx);
  }
  public function get_identity(){
    return __.option(this.type).map(x -> x.identity).defv(this.lookup);
  }
}
class LazyTypeLift{  

}