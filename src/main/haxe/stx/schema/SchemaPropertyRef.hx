package stx.schema;

typedef SchemaPropertyRefDef = {
  final field : String;
  final type  : SchemaRefDef;
}
@:forward abstract SchemaPropertyRef(SchemaPropertyRefDef) from SchemaPropertyRefDef to SchemaPropertyRefDef{
  public function new(self) this = self;
  static public function lift(self:SchemaPropertyRefDef):SchemaPropertyRef return new SchemaPropertyRef(self);
  @:noUsing static public function make(field,type){
    return lift({
      field : field,
      type  : type
    });
  }
  public function prj():SchemaPropertyRefDef return this;
  private var self(get,never):SchemaPropertyRef;
  private function get_self():SchemaPropertyRef return lift(this);
}