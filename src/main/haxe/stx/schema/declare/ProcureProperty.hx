package stx.schema.declare;

typedef ProcurePropertyDef = stx.schema.WithValidationDef & {
  final name        : std.String;
  final type        : SchemaRef;
}
@:using(stx.schema.declare.ProcureProperty.ProcurePropertyLift)
@:forward abstract ProcureProperty(ProcurePropertyDef) from ProcurePropertyDef to ProcurePropertyDef{
  static public var _(default,never) = ProcurePropertyLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:ProcurePropertyDef):ProcureProperty return new ProcureProperty(self);
  @:noUsing static public function make(name,type,?validation){
    return lift({
      name : name,
      type : type,
      validation : __.option(validation).defv(Cluster.unit())
    });
  }
  public function prj():ProcurePropertyDef return this;
  private var self(get,never):ProcureProperty;
  private function get_self():ProcureProperty return lift(this);

  public function with_type(type:SchemaRef){
    return make(this.name,type,this.validation);
  }
  public function toString(){
    return __.show({ name : this.name, type : this.type.toString() });
  }
  @:to public function toProcure(){
    return Property(this);
  }
}
class ProcurePropertyLift{
  static public function to_self_constructor(self:ProcureProperty){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.ProcureProperty.make'),
      [
        e.Const(c -> c.String(self.name)),
        self.type.to_self_constructor()   
      ]
    );
  }
}