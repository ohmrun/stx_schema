package stx.schema.declare;

interface DeclareGenericSchemaApi extends DeclareNominativeSchemaApi extends DeclareIdentifiableSchemaApi{
  final type  : SchemaRef;
  final ident : Ident;
}
class DeclareGenericSchemaCls implements DeclareGenericSchemaApi extends DeclareNominativeSchemaCls{
  public final type : SchemaRef;
  public function new(ident,type,?validation,?meta){
    super(ident,validation,meta);
    this.type       = type;
  }
  public var identity(get,null):Identity;
  public function get_identity(){ 
    return Identity.make(
      Ident.make(
        this.ident.name,
        this.ident.pack
      ),
      [Identity.lift(this.type)]
    );
  }
} 
@:forward abstract DeclareGenericSchema(DeclareGenericSchemaApi) from DeclareGenericSchemaApi to DeclareGenericSchemaApi{
  static public var _(default,never) = DeclareGenericSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareGenericSchemaApi):DeclareGenericSchema return new DeclareGenericSchema(self);

  //Identity.make(Ident.make(name,pack),Some(type.identity),None)
  @:noUsing static public function make(ident:Ident,type:SchemaRef,?validation:Validations,?meta:PExpr<Primitive>):DeclareGenericSchema{
    return lift(new DeclareGenericSchemaCls(
      ident,
      type,
      validation,
      meta
    ));
  }
  public function prj():DeclareGenericSchemaApi return this;
  private var self(get,never):DeclareGenericSchema;
  private function get_self():DeclareGenericSchema return lift(this);

  @:to public function toSchema():Schema{
    return SchGeneric(this);
  }
  public function toString(){
    final thiz = this.identity.toString();
    return thiz;
  }
} 
class DeclareGenericSchemaLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  } 
  static public function denote(self:DeclareGenericSchema){
    // final e = __.g().expr();
    // return e.Call(
    //   e.Path('stx.schema.declare.DeclareGenericSchema.make'),
    //   [
    //     e.Const( c -> c.String(self.identity.name)),
    //     e.ArrayDecl(
    //       __.option(self.identity.pack).defv([]).prj().map(
    //         str -> e.Const(
    //           c -> c.String(str)
    //         )
    //       )
    //     ),
    //     SchemaRef._.denote(self.type)
    //   ]
    // );
    return throw UNIMPLEMENTED;
  }
}