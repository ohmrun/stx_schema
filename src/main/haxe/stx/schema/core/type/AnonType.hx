package stx.schema.core.type;

import stx.schema.core.type.Field;

interface AnonTypeApi extends BaseTypeApi{
  public final fields  : Cell<Ensemble<Field>>;
}
class AnonTypeCls extends BaseTypeCls implements AnonTypeApi{
  public final fields  : Cell<Ensemble<Field>>;
  public function new(fields){
    super();
    this.fields   = fields;
    this.debrujin = Context.instance.next(); 
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
    return TAnon(Ref.pure((this:AnonType)));
  }
}
@:forward abstract AnonType(AnonTypeApi) from AnonTypeApi to AnonTypeApi{
  public function new(self) this = self;
  static public function lift(self:AnonTypeApi):AnonType return new AnonType(self);

  public function prj():AnonTypeApi return this;
  private var self(get,never):AnonType;
  private function get_self():AnonType return lift(this);
}