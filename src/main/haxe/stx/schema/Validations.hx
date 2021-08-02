package stx.schema;

@:using(stx.schema.Validations.ValidationsLift)
abstract Validations(Cluster<Validation>) from Cluster<Validation> to Cluster<Validation>{
  public function new(self) this = self;
  static public function lift(self:Cluster<Validation>):Validations return new Validations(self);

  public function prj():Cluster<Validation> return this;
  private var self(get,never):Validations;
  private function get_self():Validations return lift(this);
}
class ValidationsLift{
  static public function lfold(self:Validations,value:Dynamic,schema:Schema){
    return Cluster._.lfold(
      self,
      (next:Validation,memo:Report<SchemaFailure>) -> memo.merge(next.lfold(value,schema)),
      __.report()
    );
  }
  static public function concat(self:Validations,that:Validations){
    return Cluster._.concat(self,that);
  }
}