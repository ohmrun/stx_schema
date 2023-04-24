package stx.schema;

@:using(stx.schema.Validations.ValidationsLift)
abstract Validations(Cluster<Validation>) from Cluster<Validation> to Cluster<Validation>{
  public function new(self) this = self;
  @:noUsing static public function lift(self:Cluster<Validation>):Validations return new Validations(self);
  static public function unit():Validations{
    return lift(Cluster.unit());
  }
  public function prj():Cluster<Validation> return this;
  private var self(get,never):Validations;
  private function get_self():Validations return lift(this);
  @:from static public function fromArray(self:Array<Validation>){
    return lift(Cluster.lift(self));
  }
  @:from static public function fromValidationDef(self:ValidationDef){
    return lift(Cluster.pure(self));
  }
}
class ValidationsLift{
  static public function concat(self:Validations,that:Validations){
    return Cluster._.concat(self,that);
  }
}