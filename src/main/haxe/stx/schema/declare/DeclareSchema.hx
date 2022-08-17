package stx.schema.declare;

interface DeclareSchemaApi extends WithValidationApi{
  public final meta                 : PExpr<Primitive>;
}
abstract class DeclareSchemaCls implements DeclareSchemaApi extends WithValidationCls{
  public function new(?validation,?meta){
    super(__.option(validation).defv(Validations.unit()));
    this.meta = __.option(meta).defv(PEmpty);
  }
  public final meta                 : PExpr<Primitive>;
}
@:using(stx.schema.declare.DeclareSchema.DeclareSchemaLift)
@:forward abstract DeclareSchema(DeclareSchemaApi) from DeclareSchemaApi to DeclareSchemaApi{
  static public var _(default,never) = DeclareSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareSchemaApi):DeclareSchema return new DeclareSchema(self);

  public function prj():DeclareSchemaApi return this;
  private var self(get,never):DeclareSchema;
  private function get_self():DeclareSchema return lift(this);


}
class DeclareSchemaLift{
  static public inline function denote(self:DeclareSchema):GExpr{
    return throw UNIMPLEMENTED;
  }
}
