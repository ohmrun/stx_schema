package stx.schema.core.type;

typedef DataTypeDef = IdentDef & WithValidationDef & {

}
@:forward abstract DataType(DataTypeDef) from DataTypeDef to DataTypeDef{
  public function new(self) this = self;
  static public function lift(self:DataTypeDef):DataType return new DataType(self);

  public function prj():DataTypeDef return this;
  private var self(get,never):DataType;
  private function get_self():DataType return lift(this);
}
