package stx.schema.core.type;

import stx.schema.core.type.Field;

interface AnonTypeApi extends BaseTypeApi{
  public final fields  : Cell<Cluster<Field>>;
}
class AnonTypeCls extends BaseTypeCls implements AnonTypeApi{
  public final uuid    : String;
  public final fields  : Cell<Cluster<Field>>;
  public function new(fields,?uuid,?validation){
    super(validation);
    this.uuid     = __.option(uuid).def(__.uuid.bind('xxxxx'));
    this.fields   = fields;
    this.debrujin = 1;//Context.instance.next(); 
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
  public function toType(){
    return Type.make(TAnon(Ref.pure((this:AnonType))));
  }
  public function register(state:Context):Type{
    var next : AnonType     = null;
    var type                = Ref.make(
      () -> next
    );
    state.put(TAnon(type));
    final fs = (this.fields.pop().toIter()).lfold(
      (next:Field,memo:Cluster<Field>) -> {
        final id    = next.type.identity();
        final type  = state.get(id).fudge(__.fault().of(E_Schema_IdentityUnresolved(id)));
        return memo.snoc(Field.make(next.name,type));
      },
      Cluster.unit()
    );
    
    next = new AnonTypeCls(Cell.pure(fs),this.uuid);
    return next.toType();
  }
  public function identity():Identity{
    return Ident.make(uuid);
  }
}
@:using(stx.schema.core.type.AnonType.AnonTypeLift)
@:forward abstract AnonType(AnonTypeApi) from AnonTypeApi to AnonTypeApi{
  public function new(self) this = self;
  static public function lift(self:AnonTypeApi):AnonType return new AnonType(self);

  public function prj():AnonTypeApi return this;
  private var self(get,never):AnonType;
  private function get_self():AnonType return lift(this);

  @:noUsing static public function make(fields){ 
    return lift(new AnonTypeCls(fields));
  }
}
class AnonTypeLift{
  #if macro
  static public function main(self:AnonType,state:MacroContext){
    return throw UNIMPLEMENTED;
  }
  static public function leaf(self:AnonType,state:MacroContext){
    return throw UNIMPLEMENTED;
  }
  static public function toComplexType(self:AnonType,state:MacroContext){
    return Res.bind_fold(
      self.fields.pop(),
      (next:Field,memo:Cluster<HField>) -> 
        next.type.toComplexType(state).map(
          ct -> HField.make(
            next.name,
            HFieldType.FVar(ct),
            state.pos
          ) 
        ).map(memo.snoc),
        Cluster.unit()
    ).map(HComplexType.TAnonymous);
  }
  #end
}
