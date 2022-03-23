package stx.schema.core.type;

typedef LazyTypeDef = WithValidationDef & {
  final type : Cell<Type>;
}
abstract LazyType(LazyTypeDef) from LazyTypeDef to LazyTypeDef{
  public function new(self) this = self;
  static public function lift(self:LazyTypeDef):LazyType return new LazyType(self);
  static public function make(type:Cell<Type>){
    return lift({
      type : type 
    });
  }
  static public function fromThunk(self:Void->Type){
    return make(Cell.make(self)); 
  }
  public function prj():LazyTypeDef return this;
  private var self(get,never):LazyType;
  private function get_self():LazyType return lift(this);
}