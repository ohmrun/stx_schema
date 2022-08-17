package stx.schema.declare;

interface DeclareAnonSchemaApi extends DeclareIdentifiableSchemaApi{
  public final fields : Procurements;
}
class DeclareAnonSchemaCls implements DeclareAnonSchemaApi extends DeclareSchemaCls implements DeclareIdentifiableSchemaApi{
  public function get_validation() return this.validation;
  public function new(fields,?validation,?meta){
    super(validation,meta);
    this.fields     = fields;
  }
  public var identity(get,null):Identity;
  //TODO order
  public function get_identity(){
    return Identity.make(
      Ident.make("Anon"),
      this.fields.map(
        x -> Identity.make(Ident.make(x.name),[x.type.identity])
      )
    );
  }
  public final fields : Procurements;
}
@:forward abstract DeclareAnonSchema(DeclareAnonSchemaApi) from DeclareAnonSchemaApi to DeclareAnonSchemaApi{
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareAnonSchemaApi):DeclareAnonSchema return new DeclareAnonSchema(self);
  @:noUsing static public function make(fields,?validation,?meta){
    return lift(new DeclareAnonSchemaCls(fields,validation,meta)); 
  }
  public function prj():DeclareAnonSchemaApi return this;
  private var self(get,never):DeclareAnonSchema;
  private function get_self():DeclareAnonSchema return lift(this);

  public function toString(){
    return this.identity.canonical();
  }
}