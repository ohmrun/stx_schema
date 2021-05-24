package stx.schema.core;

enum FieldSum{
  Property(def:FieldPropertyDeclaration);
  Attribute(def:FieldAttributeDeclaration);
}
@:forward abstract Field(FieldSum) from FieldSum to FieldSum{
  public function new(self) this = self;
  static public function lift(self:FieldSum):Field return new Field(self);

  public function prj():FieldSum return this;
  private var self(get,never):Field;
  private function get_self():Field return lift(this);
}