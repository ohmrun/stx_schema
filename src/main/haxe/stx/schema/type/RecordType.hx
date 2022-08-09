package stx.schema.type;

interface RecordTypeApi extends DataTypeApi{
  public final fields  : Cell<Cluster<stx.schema.core.Field>>;
  public final ident   : Ident;
  public function toRecordTypeApi():RecordTypeApi;
}
class RecordTypeCls extends ConcreteType implements RecordTypeApi{
  public final fields  : Cell<Cluster<stx.schema.core.Field>>;
  public function new(id,ident,fields,meta,?validation){
    super(id,ident,meta,validation);
    this.fields   = fields;
  }
  override public function get_validation(){
    return Cluster.unit();
  }
  public function toSType():SType{
    return STRecord(Ref.make(() -> this.identity,() -> this.toRecordTypeApi()));
  }
  public function toString(){
    return this.identity.toString();
  }
  // public function register(state:TypeContext){
  //   var next : RecordType     = null;
  //   var type                  = Ref.make(
  //     () -> this.identity,
  //     () -> next
  //   );
  //   state.put(STRecord(type));
  //   final fs = (this.fields.pop().toIter()).lfold(
  //     (next:stx.schema.core.Field,memo:Cluster<stx.schema.core.Field>) -> {
  //       final id    = next.type.identity;
  //       final type  = state.get(id).fudge(__.fault().of(E_Schema_IdentityUnresolved(id)));
  //       return memo.snoc(stx.schema.core.Field.make(next.name,type));
  //     },
  //     Cluster.unit()
  //   );
    
  //   next = new RecordTypeCls(this.id,this.ident,fs,meta,validation);
   
  //   return next.toSType();
  // }
  public function toRecordTypeApi():RecordTypeApi{
    return this;
  }
}
@:using(stx.schema.type.RecordType.RecordTypeLift)
@:forward abstract RecordType(RecordTypeApi) from RecordTypeApi to RecordTypeApi{
  public function new(self) this = self;
  @:noUsing static public function lift(self:RecordTypeApi):RecordType return new RecordType(self);

  public function prj():RecordTypeApi return this;
  private var self(get,never):RecordType;
  private function get_self():RecordType return lift(this);

  @:noUsing static public function make(id,ident,fields,meta,?validation){ 
    return lift(new RecordTypeCls(id,ident,fields,meta,validation));
  }
  @:noUsing static public function make0(id,name,pack,fields,meta,?validation){ 
    return make(id,Ident.make(name,pack),fields,meta,validation);
  }

}
class RecordTypeLift{
  
}