package stx.schema;

abstract ID(Int) from Int to Int{
  public function new(self) this = self;
  static public function lift(self:Int):ID return new ID(self);

  public function prj():Int return this;
  private var self(get,never):ID;
  private function get_self():ID return lift(this);
}