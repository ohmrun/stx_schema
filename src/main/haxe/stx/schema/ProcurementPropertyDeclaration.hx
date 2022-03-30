package stx.schema;

typedef ProcurementPropertyDeclarationDef = stx.schema.WithValidationDef & {
  final name        : std.String;
  final type        : SchemaRef;
}
@:forward abstract ProcurementPropertyDeclaration(ProcurementPropertyDeclarationDef) from ProcurementPropertyDeclarationDef to ProcurementPropertyDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:ProcurementPropertyDeclarationDef):ProcurementPropertyDeclaration return new ProcurementPropertyDeclaration(self);
  static public function make(name,type,?validation){
    return lift({
      name : name,
      type : type,
      validation : __.option(validation).defv(Cluster.unit())
    });
  }
  public function prj():ProcurementPropertyDeclarationDef return this;
  private var self(get,never):ProcurementPropertyDeclaration;
  private function get_self():ProcurementPropertyDeclaration return lift(this);

  public function with_type(type:SchemaRef){
    return make(this.name,type,this.validation);
  }
  public function toString(){
    return __.show({ name : this.name, type : this.type.toString() });
  }
}