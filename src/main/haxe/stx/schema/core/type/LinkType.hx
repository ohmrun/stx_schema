package stx.schema.core.type;

interface LinkTypeApi extends BaseTypeApi{
  public final into      : Type;
  public final relation  : SchemaRelationSum;
  public final from      : String;
}
class LinkTypeCls extends BaseTypeCls implements LinkTypeApi{
  public final into      : Type;
  public final relation  : SchemaRelationSum;
  public final from      : String;

  public function new(into,relation,from){
    super();
    this.into       = into;
    this.relation   = relation;
    this.from       = from;
  }
  public function toType():Type{
    return TLink(Ref.pure((this:LinkType)));
  }
  public function toString(){
    return '$relation $into $from';
  }
  public function register(){
    this.into.register();
    Context.instance.put(this.toType());
  }
}
@:forward abstract LinkType(LinkTypeApi) from LinkTypeApi to LinkTypeApi{
  public function new(self) this = self;
  static public function lift(self:LinkTypeApi):LinkType return new LinkType(self);

  public function prj():LinkTypeApi return this;
  private var self(get,never):LinkType;
  private function get_self():LinkType return lift(this);
}