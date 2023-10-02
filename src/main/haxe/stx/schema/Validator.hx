package stx.schema;

typedef ValidatorDef = QExpr<LExpr<Coord,PExpr<Atom>>>;

@:using(stx.schema.Validator.ValidatorLift)
@:forward abstract Validator(ValidatorDef) from ValidatorDef to ValidatorDef{
  static public var _(default,never) = ValidatorLift;
  public inline function new(self:ValidatorDef) this = self;
  @:noUsing static inline public function lift(self:ValidatorDef):Validator return new Validator(self);

  public function prj():ValidatorDef return this;
  private var self(get,never):Validator;
  private function get_self():Validator return lift(this);
}
class ValidatorLift{
  static public inline function lift(self:ValidatorDef):Validator{
    return Validator.lift(self);
  }
}