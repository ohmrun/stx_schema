package stx.schema.declare;

import haxe.ds.Map;

typedef ProcurementsDef = RedBlackSet<stx.schema.declare.Procure>;

@:using(stx.schema.declare.Procurements.ProcurementsLift)
@:transitive @:forward(lfold,map,toIter,toCluster) abstract Procurements(ProcurementsDef) from ProcurementsDef to ProcurementsDef{
  static public var _(default,never) = ProcurementsLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:ProcurementsDef):Procurements return new Procurements(self);

  public function prj():ProcurementsDef return this;
  private var self(get,never):Procurements;
  private function get_self():Procurements return lift(this);

  @:from static public function fromObject(self:{ ?properties : Map<String,DeclareProperty>, ?attributes : Map<String,DeclareAttribute> }){
    var out : RedBlackSet<stx.schema.declare.Procure> = 
      stx.ds.RedBlackSet.make(new stx.assert.schema.declare.comparable.Procure());

    for(k => v in __.option(self.properties).defv(new Map())){
      var next : ProcurePropertyDef = {
        name :  k,
        type : v.type,
        meta : v.meta,
        validation : v.validation
      }
      out = out.put(stx.schema.declare.Procure.lift(Property(next)));
    }
    for(k => v in __.option(self.attributes).defv(new Map())){
      var next : ProcureAttributeDef = {
        name        :  k,
        type        : v.type,
        validation  : v.validation,
        meta        : v.meta,
        relation    : v.relation,
        inverse     : v.inverse
      }
      out = out.put(stx.schema.declare.Procure.lift(Attribute(next)));
    }
    return lift(out);
  }
  @:from static public function fromObjectI(self:{ ?properties : Map<String,Schema>, ?attributes : Map<String,DeclareAttribute> }){
    return fromObject({ 
      properties  : __.option(self.properties).defv(new Map()).map_into(DeclareProperty.fromSchema,new Map()), 
      attributes  : __.option(self.attributes).defv(new Map())
    });
  }
  @:from static public function fromObjectII(self:{ ?properties : Map<String,Schema>, ?attributes : Map<String,DeclareAttribute> }){
    return fromObject({ 
      properties  : __.option(self.properties).defv(new Map()).map_into(DeclareProperty.fromSchema,new Map()), 
      attributes  : __.option(self.attributes).defv(new Map())
    });
  }
  @:from static public function fromObjectIII(self:{ ?properties : Map<String,Schema>, ?attributes : Map<String,DeclareAttributeDef> }){
    return fromObject({ 
      properties  : __.option(self.properties).defv(new Map()).map_into(DeclareProperty.fromSchema,new Map()), 
      attributes  : __.option(self.attributes).defv(new Map())
    });
  }
  @:from static public function fromObjectIV(self:{ properties : haxe.ds.Map<String, stx.schema.Schema>, attributes : haxe.ds.Map<String, { ?validation : Validations, type : stx.Ident, relation : stx.schema.RelationType, ?meta : PExpr<Primitive>, ?inverse : String }> }){
    return fromObject({ 
      properties  : __.option(self.properties).defv(new Map()).map_into(DeclareProperty.fromSchema,new Map()), 
      attributes  : __.option(self.attributes).defv(new Map()).map_into((x) -> DeclareAttribute.fromObjectII(x),new Map())
    });
  }
  @:from static public function fromObjectV(self:{ properties : haxe.ds.Map<String, stx.schema.Schema>, attributes : haxe.ds.Map<String, { type : stx.Ident, relation : stx.schema.RelationType, ?meta : Null<eu.ohmrun.PExpr<stx.Primitive>>, ?inverse : String }> } ):Procurements{
    return fromObject({ 
      properties  : __.option(self.properties).defv(new Map()).map_into(DeclareProperty.fromSchema,new Map()), 
      attributes  : __.option(self.attributes).defv(new Map()).map_into((x) -> DeclareAttribute.fromObjectIV(x),new Map())
    });
  }
  @:from static public function fromObjectVI(self:{ properties : haxe.ds.Map<String, stx.schema.Schema>, ?attributes : haxe.ds.Map<String, { type : stx.Ident, relation : stx.schema.RelationType, ?meta : eu.ohmrun.pml.PExpr.PExprSum<PrimitiveDef>, ?inverse : String }> }):Procurements{
    return fromObject({ 
      properties  : __.option(self.properties).defv(new Map()).map_into(DeclareProperty.fromSchema,new Map()), 
      attributes  : __.option(self.attributes).defv(new Map()).map_into((x) -> DeclareAttribute.fromObjectIV(x),new Map())
    });
  }
  @:from static public function fromCluster(self:Cluster<Procure>){
    final set = RedBlackSet.make(new stx.assert.schema.declare.comparable.Procure());
    for(x in self){
      set.put(x);
    }
    return lift(set);
  }
  public function toString(){
    return this.toCluster().map(x -> x.toString()).join(",");
  }
}
class ProcurementsLift{
  static public function denote(self:Procurements){
    final e = __.glot().expr();
    return e.ArrayDecl(
      self.toCluster().map( p -> p.denote() )
    );
  }
}