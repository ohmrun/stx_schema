package stx.schema.core.type;

typedef AnonTypeDef = Has_toStringDef & WithValidationDef & {
  final fields  : Cell<Ensemble<Field>>;
}
@:forward abstract AnonType(AnonTypeDef) from AnonTypeDef to AnonTypeDef{
  public function new(self) this = self;
  static public function lift(self:AnonTypeDef):AnonType return new AnonType(self);

  public function prj():AnonTypeDef return this;
  private var self(get,never):AnonType;
  private function get_self():AnonType return lift(this);
}