package stx.schema.core.type;

typedef RecordTypeDef = AnonTypeDef & DataTypeDef;

@:forward abstract RecordType(RecordTypeDef) from RecordTypeDef to RecordTypeDef{
  public function new(self) this = self;
  static public function lift(self:RecordTypeDef):RecordType return new RecordType(self);

  public function prj():RecordTypeDef return this;
  private var self(get,never):RecordType;
  private function get_self():RecordType return lift(this);
}