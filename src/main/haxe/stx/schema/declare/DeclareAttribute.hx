
package stx.schema.declare;

typedef DeclareAttributeDef = DeclarePropertyDef & {
  final relation    : RelationType; 
  final ?inverse    : Null<String>;
}
@:forward abstract DeclareAttribute(DeclareAttributeDef) from DeclareAttributeDef to DeclareAttributeDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareAttributeDef):DeclareAttribute return new DeclareAttribute(self);
  @:noUsing static public function make(type,relation,?inverse){
    return lift({ type : type,relation : relation,inverse : inverse  });
  }
  public function prj():DeclareAttributeDef return this;
  private var self(get,never):DeclareAttribute;
  private function get_self():DeclareAttribute return lift(this);

  public function with_type(ref:SchemaRef){
    return lift({
      validation  : this.validation,
      relation    : this.relation,
      inverse     : this.inverse,
      type        : ref
    });
  }
  public function procure(name:String):ProcureProperty{
    return ProcureProperty.make(name,this.type);
  }
}