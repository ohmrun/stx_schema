package stx.schema.core.type;

interface DataTypeApi extends BaseTypeApi{
  public final name : String;
  public final pack : Way;

  public function ident():Ident;
}

abstract class DataTypeCls extends BaseTypeCls implements DataTypeApi{
  public final name : String;
  public final pack : Way;
  public function new(name:String,pack:Array<String>){
    super();
    this.name = name;
    this.pack = Way.lift(pack);
  }
  public function ident(){
    return Ident.make(name,pack);
  }
  public function toType(){
    return TData(Ref.pure((this:DataType)));
  }
}
@:forward abstract DataType(DataTypeApi) from DataTypeApi to DataTypeApi{
  public function new(self) this = self;
  static public function lift(self:DataTypeApi):DataType return new DataType(self);

  public function prj():DataTypeApi return this;
  private var self(get,never):DataType;
  private function get_self():DataType return lift(this);
}