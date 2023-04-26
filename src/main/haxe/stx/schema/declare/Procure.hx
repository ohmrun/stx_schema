package stx.schema.declare;

enum ProcureSum{
  Property(def:ProcureProperty);
  Attribute(def:ProcureAttribute);
}
@:using(stx.schema.declare.Procure.ProcureLift)
@:transitive @:forward abstract Procure(ProcureSum) from ProcureSum to ProcureSum{
  static public var _(default,never) = ProcureLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:ProcureSum):Procure return new Procure(self);

  public function prj():ProcureSum return this;
  private var self(get,never):Procure;
  private function get_self():Procure return lift(this);

  @:from static public function fromProcureProperty(self:ProcureProperty){
    return lift(Property(self));
  }
  @:from static public function fromProcureAttribute(self:ProcureAttribute){
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
  public function toString(){
    return _.fold(
      this,
      l -> l.toString(),
      r -> r.toString()
    );
  }
  public var validation(get,never):Validations;
  private function get_validation():Validations{
    return _.fold(
      this,
      l -> l.validation,
      r -> r.validation
    );
  }
}
class ProcureLift{
  static public function fold<Z>(self:Procure,property:ProcureProperty->Z,attribute:ProcureAttribute->Z):Z{
    return switch(self){
      case Property(def)  : property(def);
      case Attribute(def) : attribute(def);
    } 
  }
  static public function with_type(self:Procure,type:SchemaRef){
    return fold(self,t -> Property(t.with_type(type)),t -> Attribute(t.with_type(type)));
  }
  static public function denote(self:Procure){
    final e     = __.glot().expr();
    final head  = 'stx.schema.Procure.ProcureSum'; 
    return e.Call(
      e.Path(
        switch(self){
          case Property(_)   : '${head}.Property';
          case Attribute(_)  : '${head}.Attribute';
        }
      ),
      [
        switch(self){
          case Property(property)     : property.denote();
          case Attribute(attribute)   : attribute.denote(); 
        }
      ]
    );
  }
}