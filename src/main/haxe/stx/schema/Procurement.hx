package stx.schema;

enum ProcurementSum{
  Property(def:ProcurementPropertyDeclaration);
  Attribute(def:ProcurementAttributeDeclaration);
}
@:using(stx.schema.Procurement.ProcurementLift)
@:forward abstract Procurement(ProcurementSum) from ProcurementSum to ProcurementSum{
  static public var _(default,never) = ProcurementLift;
  public function new(self) this = self;
  static public function lift(self:ProcurementSum):Procurement return new Procurement(self);

  public function prj():ProcurementSum return this;
  private var self(get,never):Procurement;
  private function get_self():Procurement return lift(this);

  @:from static public function fromProcurementPropertyDeclaration(self:ProcurementPropertyDeclaration){
    return lift(Property(self));
  }
  @:from static public function fromProcurementAttributeDeclaration(self:ProcurementAttributeDeclaration){
    return lift(Attribute(self));
  }
  public var type(get,never) : SchemaRef;
  public function get_type(){
    return switch(this){
      case Property(def)  : def.type;
      case Attribute(def) : def.type;
    } 
  }
  public var name(get,never) : String;
  public function get_name(){
    return switch(this){
      case Property(def)  : def.name;
      case Attribute(def) : def.name;
    } 
  }
  public function identity(){
    return get_type().identity();
  }
  public function toString(){
    return _.fold(
      this,
      l -> l.toString(),
      r -> r.toString()
    );
  }
}
class ProcurementLift{
  static public function fold<Z>(self:Procurement,property:ProcurementPropertyDeclaration->Z,attribute:ProcurementAttributeDeclaration->Z):Z{
    return switch(self){
      case Property(def)  : property(def);
      case Attribute(def) : attribute(def);
    } 
  }
  static public function with_type(self:Procurement,type:SchemaRef){
    return fold(self,t -> Property(t.with_type(type)),t -> Attribute(t.with_type(type)));
  }
}