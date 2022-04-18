package stx.schema.type;

interface DataTypeApi extends BaseTypeApi{

}
abstract class DataTypeCls extends BaseTypeCls implements DataTypeApi{
  public function new(?meta,?validation){
    super(meta,validation);
  }
}
// abstract class DataTypeBase extends DataTypeCls{

// }
@:using(stx.schema.type.DataType.DataTypeLift)
@:forward abstract DataType(DataTypeApi) from DataTypeApi to DataTypeApi{
  static public var _(default,never) = DataTypeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DataTypeApi):DataType return new DataType(self);

  public function prj():DataTypeApi return this;
  private var self(get,never):DataType;
  private function get_self():DataType return lift(this);
}
class DataTypeLift{
  static public function main(self:DataType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
  static public function leaf(self:AnonType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
}