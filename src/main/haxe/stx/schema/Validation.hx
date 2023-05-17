package stx.schema;

typedef ValidationDef = {
  final method  : QExpr<Spine<String>>;
  final message : String;
}
@:forward abstract Validation(ValidationDef) from ValidationDef to ValidationDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:ValidationDef):Validation return new Validation(self);
     
  // @:noUsing @:from static public function fromQExpr(self:QExpr<Spine<String>>){
  //   return lift({
  //     method  : self,
  //     message : 
  //   })
  // }
  public function prj():ValidationDef return this;
  private var self(get,never):Validation;
  private function get_self():Validation return lift(this);
}