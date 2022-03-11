package stx.schema.core.type;

typedef FieldDef = {
  final type : Type;
}
abstract Field(FieldDef) from FieldDef to FieldDef{
  public function new(self) this = self;
  static public function lift(self:FieldDef):Field return new Field(self);

  public function prj():FieldDef return this;
  private var self(get,never):Field;
  private function get_self():Field return lift(this);

  @:from static public function fromType(self:Type){
    return lift({ type : self });
  }
}