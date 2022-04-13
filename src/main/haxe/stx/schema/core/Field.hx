package stx.schema.core;

typedef FieldDef = Has_toStringDef & {
  final type : SType;
  final name : String;
}
@:using(stx.schema.core.Field.FieldLift)
@:forward abstract Field(FieldDef) from FieldDef to FieldDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:FieldDef):Field return new Field(self);
  @:noUsing static public function make(name:String,type:SType):Field{
    return lift({
      name      : name,
      type      : type, 
      toString  : () -> type.toString()
    });
  }
  public function prj():FieldDef return this;
  private var self(get,never):Field;
  private function get_self():Field return lift(this);

  // @:from static public function fromString(self:String){
  //   return lift({ type : Context.instance.defer(Ident.fromIdentifier(Identifier.lift(self))), toString : () -> self });
  // }
  public function toString():String{
    return this.type.toString();
  }
}
class FieldLift{
  
}