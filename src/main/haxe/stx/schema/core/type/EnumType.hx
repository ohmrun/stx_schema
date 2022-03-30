package stx.schema.core.type;

interface EnumTypeApi extends DataTypeApi  {
  final constructors : Cluster<String>;
}
class EnumTypeCls extends DataTypeCls implements EnumTypeApi{
  public final constructors : Cluster<String>;
  public function new(name,pack,constructors,?validation){
    super(name,pack,validation);
    this.constructors = constructors;
  }
  public function register(state:Context){
    state.put(this.toType());
    return this.toType();
  }
  override public function toType():Type{
    return TEnum(Ref.pure(EnumType.lift(this)));
  }
  public function toString(){
    return this.identity().toString();
  } 
}
@:forward abstract EnumType(EnumTypeApi) from EnumTypeApi to EnumTypeApi{
  public function new(self) this = self;
  static public function lift(self:EnumTypeApi):EnumType return new EnumType(self);

  public function prj():EnumTypeApi return this;
  private var self(get,never):EnumType;
  private function get_self():EnumType return lift(this);
  static public function make(name,pack,constructors,?validation){
    return lift(new EnumTypeCls(name,pack,constructors,validation));
  }
}