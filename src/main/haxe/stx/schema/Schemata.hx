package stx.schema;

@:forward abstract Schemata(haxe.ds.StringMap<Schema>) from haxe.ds.StringMap<Schema> to haxe.ds.StringMap<Schema> {
  static public var instance(get,null) : Schemata;
  static public inline function get_instance(){
    return instance == null ? instance = new Schemata(new haxe.ds.StringMap()) : instance;
  }
  public function new(self) this = self;
  static public function lift(self:haxe.ds.StringMap<Schema>):Schemata return new Schemata(self);
  static public function unit(){
    return lift(new haxe.ds.StringMap());
  }
  public function prj():haxe.ds.StringMap<Schema> return this;
  private var self(get,never):Schemata;
  private function get_self():Schemata return lift(this);

  public function ref(path:String):SchemaRef{
    var ident = Ident.fromIdentifier(Identifier.lift(path));
    return SchemaRef.lift({
      name    : ident.name,
      pack    : ident.pack,
      get     : this.get.bind(path)
    });
  }
  public function ident(self:{ name : String, pack : Array<String> }):SchemaRef{
    var ident : Ident = self;
    return SchemaRef.lift({
      name    : ident.name,
      pack    : ident.pack,
      get     : this.get.bind(ident.toIdentifier())
    });
  }
}