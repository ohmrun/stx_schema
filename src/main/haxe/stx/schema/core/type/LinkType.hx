package stx.schema.core.type;

typedef LinkTypeDef = WithValidationDef & {
  final into      : Type,
  final relation  : SchemaRelationSum;
  final from      : String;
}
@:forward abstract LinkType(LinkTypeDef) from LinkTypeDef to LinkTypeDef{
  public function new(self) this = self;
  static public function lift(self:LinkTypeDef):LinkType return new LinkType(self);

  public function prj():LinkTypeDef return this;
  private var self(get,never):LinkType;
  private function get_self():LinkType return lift(this);
}