package stx.schema;

enum ValidationSum{
  ValidationExpr(expr:hscript.Expr);
  ValidationFunc(fn:Dynamic->Type->Report<SchemaFailure>);
}
abstract Validation(ValidationSum) from ValidationSum to ValidationSum{
  public function new(self) this = self;
  static public function lift(self:ValidationSum):Validation return new Validation(self);
     
  public function lfold(value:Dynamic,type:Type){
    return switch(this){
      case ValidationExpr(expr) : try{
        Script.interp().execute(expr)(value,type);
      }catch(e:Dynamic){
        __.report(f -> f.of(E_Schema_ValidationError(this,E_Schema_Dynamic(e))));
      }
      case ValidationFunc(fn)   : fn(value,type);
    }
  }
  @:from static public function fromValidationExpr(self:hscript.Expr){
    return lift(ValidationExpr(self));
  }
  @:from static public function fromValidationFun(self:Dynamic->Type->Report<SchemaFailure>){
    return lift(ValidationFunc(self));
  }
  public function prj():ValidationSum return this;
  private var self(get,never):Validation;
  private function get_self():Validation return lift(this);
}