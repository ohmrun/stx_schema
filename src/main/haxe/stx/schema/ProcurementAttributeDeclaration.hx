package stx.schema;

typedef ProcurementAttributeDeclarationDef = ProcurementPropertyDeclarationDef & {
  final relation   : SchemaRelationSum;
  final inverse    : String;
}
@:forward abstract ProcurementAttributeDeclaration(ProcurementAttributeDeclarationDef) from ProcurementAttributeDeclarationDef to ProcurementAttributeDeclarationDef{
  public function new(self) this = self;
  static public function lift(self:ProcurementAttributeDeclarationDef):ProcurementAttributeDeclaration return new ProcurementAttributeDeclaration(self);
  static public function make(name,type,relation,inverse,?validation){
    return lift({
      name        : name,
      type        : type,
      relation    : relation,
      inverse     : inverse,
      validation  : __.option(validation).defv(Cluster.unit())
    });
  }
  public function prj():ProcurementAttributeDeclarationDef return this;
  private var self(get,never):ProcurementAttributeDeclaration;
  private function get_self():ProcurementAttributeDeclaration return lift(this);

  public function with_type(type:SchemaRef){
    return make(this.name,type,this.relation,this.inverse,this.validation);
  }
  public function toString(){
    return __.show({name : this.name, type : this.type.toString(), relation : this.relation, inverse : this.inverse });
  }
}