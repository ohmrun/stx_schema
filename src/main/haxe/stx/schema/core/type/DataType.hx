package stx.schema.core.type;

interface DataTypeApi extends BaseTypeApi{
  public final name : String;
  public final pack : Way;
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
  public function toType(){
    return Type.make(TData(Ref.pure((this:DataType))));
  }
  public function toHaxeTypePath():haxe.macro.Expr.TypePath{
    final type_path : haxe.macro.Expr.TypePath = {
      pack : this.pack.toArray(),
      name : this.name
    };
    return type_path;
  }
}
@:forward abstract DataType(DataTypeApi) from DataTypeApi to DataTypeApi{
  public function new(self) this = self;
  static public function lift(self:DataTypeApi):DataType return new DataType(self);

  public function prj():DataTypeApi return this;
  private var self(get,never):DataType;
  private function get_self():DataType return lift(this);
}