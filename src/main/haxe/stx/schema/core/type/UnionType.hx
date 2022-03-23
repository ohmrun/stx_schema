package stx.schema.core.type;

interface UnionTypeApi extends DataTypeApi{
  final types : Cluster<Type>;
}
abstract class UnionTypeCls extends DataTypeCls{
  final types : Cluster<Type>;
  public function new(name,pack,types){
    super(name,pack);
    this.types = types;
  }
  public function register(){
    Context.instance.put(Type.Into(this.ident(),this.debrujin));
    for(type in types){
      type.register();
    }
    Context.instance.put(this.toType());
  }
}
@:forward abstract UnionType(UnionTypeApi) from UnionTypeApi to UnionTypeApi{
  public function new(self) this = self;
  static public function lift(self:UnionTypeApi):UnionType return new UnionType(self);

  public function prj():UnionTypeApi return this;
  private var self(get,never):UnionType;
  private function get_self():UnionType return lift(this);
}