package stx.schema;

typedef SchemaGenericDeclarationDef = SchemaDeclarationDef & {
  final type : SchemaRef;
}
@:forward abstract SchemaGenericDeclaration(SchemaGenericDeclarationDef) from SchemaGenericDeclarationDef to SchemaGenericDeclarationDef{
  static public var _(default,never) = SchemaGenericDeclarationLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:SchemaGenericDeclarationDef):SchemaGenericDeclaration return new SchemaGenericDeclaration(self);

  @:noUsing static public function make(name,pack,type:SchemaRef,?validation:Validations):SchemaGenericDeclaration{
    return lift({
      id            : Identity.fromIdent(Ident.make(name,pack)),
      type          : type,
      validation    : _.validation.concat(__.option(validation).defv(Cluster.unit()))
    });
  }
  public function identity(){
    return Identity.make(
      Ident.make(
        this.id.name,
        this.id.pack
      ),
      Some(Identity.lift(this.type)),
      None
    );
  }
  public function resolve(state:TyperContext){
    final typeI   = state.get(this.type.identity()).map(SchemaRef.fromSchema).def(
      () -> this.type.resolve(state)
    );
    final result  = SchGeneric(make(this.id.name,this.id.pack,typeI,this.validation));
    state.put(result);
    return result; 
  }
  public function prj():SchemaGenericDeclarationDef return this;
  private var self(get,never):SchemaGenericDeclaration;
  private function get_self():SchemaGenericDeclaration return lift(this);

  @:to public function toSchema():Schema{
    return SchGeneric(this);
  }
  public function toString(){
    final thiz = identity().toString();
    return thiz;
  }
} 
class SchemaGenericDeclarationLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.unit();
  } 
  static public function to_self_constructor(self:SchemaGenericDeclaration){
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.SchemaGenericDeclaration.make'),
      [
        e.Const( c -> c.String(self.id.name)),
        e.ArrayDecl(
          __.option(self.id.pack).defv([]).prj().map(
            str -> e.Const(
              c -> c.String(str)
            )
          )
        ),
        SchemaRef._.to_self_constructor(self.type)
      ]
    );
  }
}