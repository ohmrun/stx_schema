package stx.schema.core.type;

import stx.schema.core.type.Field;

interface AnonTypeApi extends BaseTypeApi{
  public final fields  : Cell<Ensemble<Field>>;
}
class AnonTypeCls extends BaseTypeCls implements AnonTypeApi{
  public final uuid    : String;
  public final fields  : Cell<Ensemble<Field>>;
  public function new(fields,?uuid,?validation){
    super(validation);
    this.uuid     = __.option(uuid).def(__.uuid.bind('xxxxx'));
    this.fields   = fields;
    this.debrujin = 1;//Context.instance.next(); 
  }
  public function toString(){
    final arr = [];
    for(k => v in fields.pop()){
      arr.push('${k} => ${v.toString()}');
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
    final fs = (this.fields.pop().toIterKV().toIter()).lfold(
      (next:KV<String,Field>,memo:Ensemble<Field>) -> {
        final id    = next.val.type.identity();
        final type  = state.get(id).fudge(__.fault().of(E_Schema_IdentityUnresolved(id)));
        return memo.set(next.key,Field.make(type));
      },
      Ensemble.unit()
    );
    
    next = new AnonTypeCls(fs,this.uuid);
    return next.toType();
  }
  public function identity():Identity{
    return Ident.make(uuid);
  }
}
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