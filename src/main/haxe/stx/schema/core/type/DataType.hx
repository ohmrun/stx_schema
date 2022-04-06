package stx.schema.core.type;

interface DataTypeApi extends BaseTypeApi{
  public final name : String;
  public final pack : Way;

  public function ident():Ident;
}
abstract class DataTypeCls extends BaseTypeCls implements DataTypeApi{
  public final name : String;
  public final pack : Way;
  public function new(name:String,pack:Array<String>,?validation){
    super(validation);
    this.name = name;
    this.pack = Way.lift(pack);
  }
  public function identity(){
    return Identity.fromIdent(Ident.make(name,pack));
  }
  public function ident():Ident{
    return Ident.make(name,pack);
  }
  public function toType(){
    return Type.make(TData(Ref.pure((this:DataType))));
  }
}
@:using(stx.schema.core.type.DataType.DataTypeLift)
@:forward abstract DataType(DataTypeApi) from DataTypeApi to DataTypeApi{
  static public var _(default,never) = DataTypeLift;
  public function new(self) this = self;
  static public function lift(self:DataTypeApi):DataType return new DataType(self);

  public function prj():DataTypeApi return this;
  private var self(get,never):DataType;
  private function get_self():DataType return lift(this);
}
class DataTypeLift{
  #if macro
  static public function main(self:DataType,state:MacroContext){
    return throw UNIMPLEMENTED;
  }
  static public function leaf(self:AnonType,state:MacroContext){
    return throw UNIMPLEMENTED;
  }
  static public function toComplexType(self:DataType,state:MacroContext):Res<HComplexType,SchemaFailure>{
    return __.accept(HTypePath.make(self.name,self.pack).toComplexType());
  }
  #end
}