package stx.schema;

import haxe.ds.Map;

typedef ProcurementsDef = Cluster<Procurement>;

@:using(stx.schema.Procurements.ProcurementsLift)
@:forward(lfold,map) abstract Procurements(ProcurementsDef) from ProcurementsDef to ProcurementsDef{
  static public var _(default,never) = ProcurementsLift;
  public function new(self) this = self;
  static public function lift(self:ProcurementsDef):Procurements return new Procurements(self);

  public function prj():ProcurementsDef return this;
  private var self(get,never):Procurements;
  private function get_self():Procurements return lift(this);

  @:from static public function fromObject(self:{ ?properties : Map<String,PropertyDeclaration>, ?attributes : Map<String,AttributeDeclaration> }){
    final out = [];

    for(k => v in __.option(self.properties).defv(new Map())){
      var next : ProcurementPropertyDeclarationDef = {
        name :  k,
        type : v.type
      }
      out.push(Property(next));
    }
    for(k => v in __.option(self.attributes).defv(new Map())){
      var next : ProcurementAttributeDeclarationDef = {
        name :  k,
        type        : v.type,
        validation  : v.validation,
        relation    : v.relation,
        inverse     : v.inverse
      }
      out.push(Attribute(next));
    }
    return lift(Cluster.lift(out));
  }
  public function toString(){
    return this.map(x -> x.toString()).join(",");
  }
}
class ProcurementsLift{
  static public function to_self_constructor(self:Procurements){
    final e = __.g().expr();
    return e.ArrayDecl(
      self.map( p -> p.to_self_constructor() )
    );
  }
}