package stx.schema;

typedef SchemaRefDef = SchemaIdentDef & {
  public function get():Schema;
}
@:forward abstract SchemaRef(SchemaRefDef) from SchemaRefDef to SchemaRefDef{
  public function new(self) this = self;
  static public function lift(self:SchemaRefDef):SchemaRef return new SchemaRef(self);

  static public function make(name:String,get:Void->Schema){
    return lift({
      name  : name,
      get   : get 
    });
  }
  @:from static inline public function fromSchema(self:Schema){
    return lift({
      name  : self.name,
      pack  : self.pack,
      get   : () -> self
    });
  }
  public function prj():SchemaRefDef return this;
  private var self(get,never):SchemaRef;
  private function get_self():SchemaRef return lift(this);
}