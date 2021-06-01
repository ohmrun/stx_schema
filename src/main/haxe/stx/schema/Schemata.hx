package stx.schema;

interface Schemata{
  public function put(val:Schema):Void;
  public function get(key:String):Option<Schema>;

  public function use(key:String):Res<Schema,SchemaFailure>;
}