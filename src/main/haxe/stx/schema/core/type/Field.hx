package stx.schema.core.type;

typedef FieldDef = Has_toStringDef & {
  final type : Type;
}
@:forward abstract Field(FieldDef) from FieldDef to FieldDef{
  public function new(self) this = self;
  static public function lift(self:FieldDef):Field return new Field(self);
  static public function make(type:Type):Field{
    return lift({
      type      : type, 
      toString  : () -> type.toString()
    });
  }
  public function prj():FieldDef return this;
  private var self(get,never):Field;
  private function get_self():Field return lift(this);

  @:from static public function fromType(self:Type){
    return lift({ type : self , toString : () -> self.toString() });
  }
  @:from static public function fromString(self:String){
  return lift({ type : Context.instance.defer(Ident.fromIdentifier(Identifier.lift(self))), toString : () -> self });
  }
  public function toString():String{
    return this.type.toString();
  }
}