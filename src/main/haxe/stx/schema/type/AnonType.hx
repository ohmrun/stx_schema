package stx.schema.type;

import stx.schema.core.Field;

interface AnonTypeApi extends BaseTypeApi{
  public final fields  : Cell<Cluster<Field>>;
}
class AnonTypeCls extends BaseTypeCls implements AnonTypeApi{
  public final fields  : Cell<Cluster<Field>>;
  public function new(fields,?meta,?validation){
    super(meta,validation);
    this.fields   = fields;
  }
  public function toString(){
    final arr = [];
    for(field in fields.pop()){
      arr.push('${field.name} => ${field.type.toString()}');
    }
    return arr.join(",");
  }
  override public function get_validation(){
    return Cluster.unit();
  }
  public function toSType(){
    return SType.make(STAnon(Ref.make(() -> this.identity,() -> (this:AnonType))));
  }
  public function register(state:TypeContext):SType{
    var next : AnonType     = null;
    var type                = Ref.make(
      () -> this.identity,
      () -> next
    );
    state.put(STAnon(type));
    final fs = (this.fields.pop().toIter()).lfold(
      (next:Field,memo:Cluster<Field>) -> {
        final id    = next.type.identity;
        final type  = state.get(id).fudge(__.fault().of(E_Schema_IdentityUnresolved(id)));
        return memo.snoc(Field.make(next.name,type));
      },
      Cluster.unit()
    );
    
    next = new AnonTypeCls(Cell.pure(fs));
    return next.toSType();
  }
  public function get_identity():Identity{
    final ident            = Ident.make('Anon');
    final field_identities = this.fields.pop().map(
      field -> Identity.make(Ident.make('Anon_${field.name}'),[field.type.identity])
    );
    return Identity.make(ident,field_identities);
  }
}
@:using(stx.schema.type.AnonType.AnonTypeLift)
@:forward abstract AnonType(AnonTypeApi) from AnonTypeApi to AnonTypeApi{
  public function new(self) this = self;
  @:noUsing static public function lift(self:AnonTypeApi):AnonType return new AnonType(self);

  public function prj():AnonTypeApi return this;
  private var self(get,never):AnonType;
  private function get_self():AnonType return lift(this);

  @:noUsing static public function make(fields,meta,?validation){ 
    return new AnonTypeCls(fields,meta,validation);
  }
}
class AnonTypeLift{
  static public function toGComplexType_with(self:AnonType,rest:SType->Res<GComplexType,SchemaFailure>){
    return Res.bind_fold(
      self.fields.pop(),
      (next:Field,memo:Cluster<GField>) -> 
        rest(next.type).map(
          ctype -> __.g().field().Make(
            next.name,
            ftype -> ftype.Var(ctype),
            acc   -> [acc.Public(),acc.Final()]
          )
        ).map(memo.snoc)
      ,[].imm()
    ).map(
      (fields) -> __.g().ctype().Anonymous(fields)
    );
  }
}
