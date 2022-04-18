package stx.schema.declare;

typedef DeclarePropertyDef = stx.schema.WithValidationDef & {
  final type        : SchemaRef;
}
@:forward abstract DeclareProperty(DeclarePropertyDef) from DeclarePropertyDef to DeclarePropertyDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclarePropertyDef):DeclareProperty return new DeclareProperty(self);
  @:noUsing static public function make(type:SchemaRef){
    return lift({ type : type  });
  }
  public function prj():DeclarePropertyDef return this;
  private var self(get,never):DeclareProperty;
  private function get_self():DeclareProperty return lift(this);

  @:from static public function fromDeclareScalarSchemaApi(self:DeclareScalarSchemaApi){
    return lift({
      type : SchemaRef.fromDeclareScalarSchema(self)
    });
  }
  @:from static public function fromSchema(self:Schema){
    return lift({
      type : SchemaRef.fromSchema(self)
    });
  }
  public function with_type(ref:SchemaRef){
    return lift({
      validation  : this.validation,
      type        : ref
    });
  }
  public function procure(name:String):ProcureProperty{
    return ProcureProperty.make(name,this.type);
  }
}