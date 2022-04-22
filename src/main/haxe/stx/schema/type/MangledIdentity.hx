package stx.schema.type;

abstract MangledIdentity(String) from String{
  static public final prefix = "_H";

  public function new(self) this = self;
  static public function lift(self:String):MangledIdentity return new MangledIdentity(self);

  public function prj():String return this;
  private var self(get,never):MangledIdentity;
  private function get_self():MangledIdentity return lift(this);
}