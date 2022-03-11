package stx.schema.core.type;

typedef MetaTypeDef = {

}
abstract MetaType(MetaTypeDef) from MetaTypeDef to MetaTypeDef{
  public function new(self) this = self;
  static public function lift(self:MetaTypeDef):MetaType return new MetaType(self);

  public function prj():MetaTypeDef return this;
  private var self(get,never):MetaType;
  private function get_self():MetaType return lift(this);
}