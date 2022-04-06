package stx.schema.core.type;

interface RecordTypeApi extends DataTypeApi{
  public final fields  : Cell<Cluster<stx.schema.core.type.Field>>;
}
class RecordTypeCls extends DataTypeCls implements RecordTypeApi{
  public final fields  : Cell<Cluster<stx.schema.core.type.Field>>;
  public function new(name,pack,fields){
    super(name,pack);
    this.fields   = fields;
  }
  override public function get_validation(){
    return Cluster.unit();
  }
  public function toString(){
    return this.identity().toString();
  }
  public function register(state:Context){
    var next : RecordType     = null;
    var type                  = Ref.make(
      () -> next
    );
    state.put(TRecord(type));
    final fs = (this.fields.pop().toIter()).lfold(
      (next:stx.schema.core.type.Field,memo:Cluster<stx.schema.core.type.Field>) -> {
        final id    = next.type.identity();
        final type  = state.get(id).fudge(__.fault().of(E_Schema_IdentityUnresolved(id)));
        return memo.snoc(stx.schema.core.type.Field.make(next.name,type));
      },
      Cluster.unit()
    );
    
    next = new RecordTypeCls(this.name,this.pack,fs);
   
    return next.toType();
  }
}
@:using(stx.schema.core.type.RecordType.RecordTypeLift)
@:forward abstract RecordType(RecordTypeApi) from RecordTypeApi to RecordTypeApi{
  public function new(self) this = self;
  static public function lift(self:RecordTypeApi):RecordType return new RecordType(self);

  public function prj():RecordTypeApi return this;
  private var self(get,never):RecordType;
  private function get_self():RecordType return lift(this);

  @:noUsing static public function make(name,pack,fields){ 
    return lift(new RecordTypeCls(name,pack,fields));
  }
}
class RecordTypeLift{
  #if macro
  static public function main(self:RecordType,state:MacroContext):Void{
    return throw UNIMPLEMENTED;
  }
  static public function leaf(self:RecordType,state:MacroContext):Void{
    return throw UNIMPLEMENTED;
  }
  static public function toComplexType(self:RecordType,state:MacroContext):Res<HComplexType,SchemaFailure>{
    return __.accept(HTypePath.make(self.name,self.pack).toComplexType());
  }
  #end
}