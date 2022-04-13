package stx.schema;

class TypeContext extends Clazz{
  @:noUsing static public function make(){
    return new TypeContext();
  }
public final register : StringMap<SType>;
  
  private var index    : Int;
  
  private function new(){
    super();   
    this.register = new StringMap();
    this.put(new stx.schema.type.term.TypeBool().toSType());
    this.put(new stx.schema.type.term.TypeFloat().toSType());
    this.put(new stx.schema.type.term.TypeInt().toSType());
    this.put(new stx.schema.type.term.TypeString().toSType());
  //  this.trigger  = Signal.trigger();
    this.index    = 0; 
  }
  public function put(type:SType){
    this.register.set(type.identity().toString(),type);
  }
  public function next():Int{
    var n = index;
    this.index = this.index + 1;
    return n;
  }
  public function get(identity:Identity):Option<SType>{
    __.log().trace(identity.toString());
    return __.option(register.get(identity.toString()));
  }
  public function has(type:SType){
    return register.exists(type.toString());
  }
  static public function unit(){
    return new TypeContext();    
  }
  public function toString(){
    return Iter.lift(this.register).map(
      x -> x.toString()
    ).toArray().join(",");
  }
}