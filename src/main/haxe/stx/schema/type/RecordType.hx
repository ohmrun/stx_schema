package stx.schema.type;

interface RecordTypeApi extends DataTypeApi{
  public final fields  : Cell<Cluster<stx.schema.core.Field>>;
  public final ident   : Ident;
  public function toRecordTypeApi():RecordTypeApi;
}
class RecordTypeCls extends NominativeTypeCls implements RecordTypeApi{
  public final fields  : Cell<Cluster<stx.schema.core.Field>>;
  public function new(register,ident,fields,?validation,?meta){
    super(register,ident,validation,meta);
    this.fields   = fields;
  }
  override public function get_validation(){
    return Cluster.unit();
  }
  public function toSType():SType{
    return STRecord(Ref.wrap((this:RecordType)));
  }
  public function toString(){
    return this.identity.toString();
  }
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

  @:noUsing static public function make(register,ident,fields,?validation,?meta){ 
    return lift(new RecordTypeCls(register,ident,fields,validation,meta));
  }
  public function copy(?register,?ident,?fields,?validation,?meta){
    return make(
      __.option(register).defv(this.register),
      __.option(ident).defv(this.ident),
      __.option(fields).defv(this.fields),
      __.option(validation).defv(this.validation),
      __.option(meta).defv(this.meta)
    );
  }
}
class RecordTypeLift{
  
}