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
  @:from static public function fromValidationSum(self:ValidationSum){
    return lift(Cluster.pure(self));
  }
}
class ValidationsLift{
  static public function lfold(self:Validations,value:Dynamic,type:SType){
    return Cluster._.lfold(
      self,
      (next:Validation,memo:Report<SchemaFailure>) -> memo.concat(next.lfold(value,type)),
      __.report()
    );
  }
  static public function concat(self:Validations,that:Validations){
    return Cluster._.concat(self,that);
  }
}