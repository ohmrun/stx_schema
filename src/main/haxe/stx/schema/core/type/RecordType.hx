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
  public function register(state:TypeContext){
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
  static public function main(self:RecordType,state:GTypeContext):Void{
    return throw UNIMPLEMENTED;
  }
  static public function leaf(self:RecordType,state:GTypeContext):Void{
    return throw UNIMPLEMENTED;
  }
  static public function getLeafTypeDefinition(self:RecordType){
    final g = __.g();

    return g.type().Make(
      '${self.name}Leaf',
      self.pack,
      tkind -> tkind.Structure(),
      fields -> self.fields.pop().map(
        field -> 
          fields.Make(
            field.name,
            kind -> field.type.is_link().if_else(
              () -> switch(field.type){
                case TLink(t)       :
                  final type = g.pop();
                  switch(type.relation){
                    case HAS_MANY   : 
                      __.g()
                        .ctype()
                        .Path(
                          p -> p.Make(
                            'Array',['std'],null,
                            tparam -> tparam.ComplexType(
                              ctype ->  
                            )
                          )
                        )
                    default         : __.g().ctype().fromString('stx.schema.ID');   
                  }
                default             : throw 'e_undefined';
              } 
              () -> kind.Var(
                t -> field.type.getLeafComplexType()
              )
            ),
            acc -> [acc.Public(),acc.Final()]
          )
      )
    );
  }
  static public function getMainTypeDefinition(self:RecordType){
    final g = __.g();
    return g.type().Make(
      '${self.name}Main',
      self.pack,
      tkind -> tkind.Structure(),
      fields -> self.fields.pop().map(
        field -> 
          fields.Make(
            field.name,
            kind -> field.type.is_link().if_else(
              () -> switch(field.type){
                case TLink(t) : switch(t.relation){
                  case HAS_MANY : 
                }
                default       : throw 'e_undefined';
              },
              () -> kind.Var(
                t -> field.type.getMainComplexType()
              )
            )
            acc -> [acc.Public(),acc.Final()]
          )
      )
    );
  }
}