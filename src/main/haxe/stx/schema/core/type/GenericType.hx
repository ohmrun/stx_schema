package stx.schema.core.type;

typedef GenericTypeDef = DataTypeDef & {
  final type : Type;
}
@:forward abstract GenericType(GenericTypeDef) from GenericTypeDef to GenericTypeDef{
  public function new(self) this = self;
  static public function lift(self:GenericTypeDef):GenericType return new GenericType(self);

  public function prj():GenericTypeDef return this;
  private var self(get,never):GenericType;
  private function get_self():GenericType return lift(this);
}