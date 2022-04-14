package stx.schema.declare;

typedef ProcureAttributeDef = ProcurePropertyDef & {
  final relation   : RelationType;
  final inverse    : String;
}
@:using(stx.schema.declare.ProcureAttribute.ProcureAttributeLift)
@:forward abstract ProcureAttribute(ProcureAttributeDef) from ProcureAttributeDef to ProcureAttributeDef{
   static public var _(default,never) = ProcureAttributeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:ProcureAttributeDef):ProcureAttribute return new ProcureAttribute(self);
  @:noUsing static public function make(name,type,relation,inverse,?validation){
    return lift({
      name        : name,
      type        : type,
      relation    : relation,
      inverse     : inverse,
      validation  : __.option(validation).defv(Cluster.unit())
    });
  }
  public function prj():ProcureAttributeDef return this;
  private var self(get,never):ProcureAttribute;
  private function get_self():ProcureAttribute return lift(this);

  public function with_type(type:SchemaRef){
    return make(this.name,type,this.relation,this.inverse,this.validation);
  }
  public function toString(){
    return __.show({name : this.name, type : this.type.toString(), relation : this.relation, inverse : this.inverse });
  }
  @:to public function toProcure(){
    return Attribute(this);
  }
}
class ProcureAttributeLift{
  static public function to_self_constructor(self:ProcureAttribute){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.ProcureAttribute.make'),
      [
        e.Const(c -> c.String(self.name)),
        self.type.to_self_constructor(),
        e.Path('stx.schema.RelationType.${self.relation}'),
        e.Const(c -> c.String(self.inverse))
      ]
    );
  }
}