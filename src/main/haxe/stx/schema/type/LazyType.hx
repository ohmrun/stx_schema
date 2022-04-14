package stx.schema.type;

@:using(stx.schema.type.LazyType.LazyTypeLift)
class LazyType extends BaseTypeCls{
  public var type(get,null) :Null<SType>;
  public final lookup : Identity;

  public function get_type(){
    //throw "here";
    __.log().trace('lazy: ${ctx.get(this.lookup)}');
    return ctx.get(this.lookup).defv(null);
  }
  private final ctx : TypeContext;
  
  public function new(lookup,ctx,?meta,?validations){
    super(meta,validations);
    
    this.ctx    = ctx;
    this.lookup = lookup;
  }
  private function get_type_option(){
    return type == null ? None : Some(type);
  }
  override function get_validation():Validations{
    return get_type_option().map((x:SType) -> x.validation).defv([].imm());
  }
  public function register(state:TypeContext){
    //state.put(this.StoSType());
    return this.toSType();
  }
  public function toSType():SType{
    return STLazy(Ref.pure(this));
  }
  public function toString(){
    return identity.toString();
  }
  @:noUsing static public function make(id,context){
    return new LazyType(id,context);
  }
  public function get_identity(){
    return __.option(this.type).map(x -> x.identity).defv(this.lookup);
  }
}
class LazyTypeLift{  

}