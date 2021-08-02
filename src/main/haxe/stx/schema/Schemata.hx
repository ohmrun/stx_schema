package stx.schema;

@:forward abstract Schemata(haxe.ds.StringMap<Schema>) from haxe.ds.StringMap<Schema> to haxe.ds.StringMap<Schema> {
  public function new(self) this = self;
  static public function lift(self:haxe.ds.StringMap<Schema>):Schemata return new Schemata(self);
  static public function unit(){
    return lift(new haxe.ds.StringMap());
  }
  public function prj():haxe.ds.StringMap<Schema> return this;
  private var self(get,never):Schemata;
  private function get_self():Schemata return lift(this);

  public function ref(path:String):SchemaRef{
    var ident = Identifier.lift(path).toIdentDef();
    return SchemaRef.lift({
      name    : ident.name,
      pack    : ident.pack,
      get     : this.get.bind(path)
    });
  }
}