package stx.schema.type;

interface ScalarTypeApi extends DataTypeApi{
  final ctype : GComplexType;
  final ident : Ident;
}
abstract class ScalarTypeCls extends DataTypeCls implements ScalarTypeApi{
  public function new(ident,ctype,meta,?validation){
    this.ident = ident;
    this.ctype = ctype;
    super(meta,validation);
  }
  public function toSType(){
    return SType.make(STScalar(Ref.make(() -> this.identity,() -> (this:ScalarType))));
  }
}
// abstract class ScalarTypeBase extends ScalarTypeCls{

// }
@:using(stx.schema.type.ScalarType.ScalarTypeLift)
@:forward abstract ScalarType(ScalarTypeApi) from ScalarTypeApi to ScalarTypeApi{
  static public var _(default,never) = ScalarTypeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:ScalarTypeApi):ScalarType return new ScalarType(self);

  public function prj():ScalarTypeApi return this;
  private var self(get,never):ScalarType;
  private function get_self():ScalarType return lift(this);
}
class ScalarTypeLift{
  
}