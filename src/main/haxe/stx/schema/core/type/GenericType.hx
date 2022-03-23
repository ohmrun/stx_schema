package stx.schema.core.type;

interface GenericTypeApi extends DataTypeApi{
  public final type : Type;
}
abstract class GenericTypeCls extends DataTypeCls implements GenericTypeApi{
  public final type : Type;
  public function new(name,pack,type){
    super(name,pack);
    this.type = type;
  }
  public function toString(){
    final outer = this.ident().toIdentifier().toString();
    final inner = this.type.toString();
    return '#$outer($inner)';
  }
  override public function toType():Type{
    return TGeneric(Ref.pure((this:GenericType)));
  }
}
@:forward abstract GenericType(GenericTypeApi) from GenericTypeApi to GenericTypeApi{
  public function new(self) this = self;
  static public function lift(self:GenericTypeApi):GenericType return new GenericType(self);

  public function prj():GenericTypeApi return this;
  private var self(get,never):GenericType;
  private function get_self():GenericType return lift(this);
}