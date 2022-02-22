package stx.schema;

typedef SchemaRefDef = SchemaIdentDef & {
  public function get():Schema;
}
@:forward abstract SchemaRef(SchemaRefDef) from SchemaRefDef to SchemaRefDef{
  public function new(self) this = self;
  static public function lift(self:SchemaRefDef):SchemaRef return new SchemaRef(self);

  static public function pure(self:{name : String, ?pack : Array<String>}){
    return Schemata.instance.ident(self);
  }
  static public function make(name:String,get:Void->Schema,?pack:Cluster<String>){
    return lift({
      name  : name,
      pack  : __.option(pack).defv(Cluster.unit()),
      get   : get 
    });
  }
  @:from static inline public function fromSchemaSum(self:SchemaSum){
    final that : Schema = Schema.lift(self);
    return lift({
      name  : that.name,
      pack  : that.pack,
      get   : () -> that
    });
  }
  @:from static inline public function fromSchema(self:Schema){
    return lift({
      name  : self.name,
      pack  : self.pack,
      get   : () -> self
    });
  }
  @:from static inline public function fromSchemaDeclaration(self:SchemaDeclarationDef){
    return fromSchemaSum(Schema.fromSchemaDeclaration(self));
  }
  public function prj():SchemaRefDef return this;
  private var self(get,never):SchemaRef;
  private function get_self():SchemaRef return lift(this);
}