package stx.schema.core.type;

interface UnionTypeApi extends DataTypeApi{
  final lhs : Type;
  final rhs : Type;
}
class UnionTypeCls extends DataTypeCls implements UnionTypeApi {
  public final lhs : Type;
  public final rhs : Type;
  public function new(name,pack,lhs,rhs){
    super(name,pack);
    this.lhs = lhs;
    this.rhs = rhs;
  }
  override public function identity(){
    return Identity.make(
      Ident.make(name,pack),
      Some(lhs.identity()),
      Some(rhs.identity())
    );
  }
  public function register(state:Context):Type{
    var next : UnionType    = null;
    final t                 = Ref.make(
      () -> next
    );
    state.put(TUnion(t));

    final l   = state.get(lhs.identity()).fudge(f -> f.of(E_Schema_IdentityUnresolved(lhs.identity())));
    final r   = state.get(rhs.identity()).fudge(f -> f.of(E_Schema_IdentityUnresolved(rhs.identity())));
  
    next = new UnionTypeCls(this.name,this.pack,l,r);
    return TUnion(next);
  }
  public function toString(){
    return this.identity().toString();
  }
}
@:forward abstract UnionType(UnionTypeApi) from UnionTypeApi to UnionTypeApi{
  public function new(self) this = self;
  static public function lift(self:UnionTypeApi):UnionType return new UnionType(self);

  public function prj():UnionTypeApi return this;
  private var self(get,never):UnionType;
  private function get_self():UnionType return lift(this);

  @:noUsing static public function make(name,pack,lhs,rhs){ 
    return lift(new UnionTypeCls(name,pack,lhs,rhs));
  }
}