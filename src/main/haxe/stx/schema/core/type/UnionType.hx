package stx.schema.core.type;

typedef UnionTypeDef = DataTypeDef & {
  final types : Cluster<Type>;
}
@:forward abstract UnionType(UnionTypeDef) from UnionTypeDef to UnionTypeDef{
  public function new(self) this = self;
  static public function lift(self:UnionTypeDef):UnionType return new UnionType(self);

  public function prj():UnionTypeDef return this;
  private var self(get,never):UnionType;
  private function get_self():UnionType return lift(this);
}