package stx.schema;

typedef SchemasDef = Array<Schema>;

@:using(stx.schema.Schemas.SchemasLift)
@:forward(iterator,concat,push) abstract Schemas(SchemasDef) from SchemasDef to SchemasDef{
  static public var _(default,never) = SchemasLift;
  public inline function new(self:SchemasDef) this = self;
  @:noUsing static inline public function lift(self:SchemasDef):Schemas return new Schemas(self);

  @:to
  public function toIter():Iter<Schema>{
    return this;
  }
  public function get(key:Identity){
    __.log().trace('search schema: $key');
    return this.search(
      (x) -> {
        __.log().trace('$x');
        return x.identity.equals(key);
      }
    );
  }
  public function prj():SchemasDef return this;
  private var self(get,never):Schemas;
  private function get_self():Schemas return lift(this);
}
class SchemasLift{
  static public inline function lift(self:SchemasDef):Schemas{
    return Schemas.lift(self);
  }
}