package stx.schema.core.type;

abstract ClassType(haxe.macro.Type.ClassType) from haxe.macro.Type.ClassType to haxe.macro.Type.ClassType{
  public function new(self) this = self;
  static public function lift(self:haxe.macro.Type.ClassType):ClassType return new ClassType(self);

  public function prj():haxe.macro.Type.ClassType return this;
  private var self(get,never):ClassType;
  private function get_self():ClassType return lift(this);
}