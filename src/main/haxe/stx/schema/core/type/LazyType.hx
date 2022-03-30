package stx.schema.core.type;

class LazyType extends BaseTypeCls{
  public var type(get,null) :Null<Type>;
  public function get_type(){
    throw "here";
    trace('lazy: ${ctx.get(this.id)}');
    return ctx.get(this.id).defv(null);
  }
  private final id  : Identity;
  private final ctx : Context;
  public function new(id,ctx,?validations){
    super(validations);
    this.id   = id;
    this.ctx  = ctx;
  }
  public var name(get,null):String;
  function get_name(){
    return this.id.name;
  }
  public var pack(get,null):Way;
  function get_pack(){
    return this.id.pack;
  }
  public function identity(){
    return this.id;
  }
  private function get_type_option(){
    return type == null ? None : Some(type);
  }
  override function get_validation():Validations{
    return get_type_option().map((x:Type) -> x.validation).defv([].imm());
  }
  public function register(state:Context){
    //state.put(this.toType());
    return this.toType();
  }
  public function toType():Type{
    return TLazy(Ref.pure(this));
  }
  public function toString(){
    return id.toString();
  }
  static public function make(id,context){
    return new LazyType(id,context);
  }
}