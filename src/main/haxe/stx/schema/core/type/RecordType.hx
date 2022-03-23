package stx.schema.core.type;

interface RecordTypeApi extends DataTypeApi{
  public final fields  : Cell<Ensemble<stx.schema.core.type.Field>>;
}
class RecordTypeCls extends DataTypeCls implements RecordTypeApi{
  public final fields  : Cell<Ensemble<stx.schema.core.type.Field>>;
  public function new(name,pack,fields){
    super(name,pack);
    this.fields   = fields;
  }
  override public function get_validation(){
    return Cluster.unit();
  }
  public function toString(){
    return this.ident().toIdentifier().toString();
  }
  public function register(){
    Context.instance.put(Type.Into(this.ident(),this.debrujin));
    
    for(field in fields.pop()){
      field.type.register();
    }
    Context.instance.put(this.toType());
  }
}
@:forward abstract RecordType(RecordTypeApi) from RecordTypeApi to RecordTypeApi{
  public function new(self) this = self;
  static public function lift(self:RecordTypeApi):RecordType return new RecordType(self);

  public function prj():RecordTypeApi return this;
  private var self(get,never):RecordType;
  private function get_self():RecordType return lift(this);
}