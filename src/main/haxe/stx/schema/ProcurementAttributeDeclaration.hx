package stx.schema;

typedef ProcurementAttributeDeclarationDef = ProcurementPropertyDeclarationDef & {
  final relation   : SchemaRelationSum;
  final inverse    : String;
}
@:using(stx.schema.ProcurementAttributeDeclaration.ProcurementAttributeDeclarationLift)
@:forward abstract ProcurementAttributeDeclaration(ProcurementAttributeDeclarationDef) from ProcurementAttributeDeclarationDef to ProcurementAttributeDeclarationDef{
   static public var _(default,never) = ProcurementAttributeDeclarationLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:ProcurementAttributeDeclarationDef):ProcurementAttributeDeclaration return new ProcurementAttributeDeclaration(self);
  @:noUsing static public function make(name,type,relation,inverse,?validation){
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
class ProcurementAttributeDeclarationLift{
  static public function to_self_constructor(self:ProcurementAttributeDeclaration){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.ProcurementAttributeDeclaration.make'),
      [
        e.Const(c -> c.String(self.name)),
        self.type.to_self_constructor(),
        e.Path('stx.schema.SchemaRelationSum.${self.relation}'),
        e.Const(c -> c.String(self.inverse))
      ]
    );
  }
}