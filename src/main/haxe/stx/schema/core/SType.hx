package stx.schema.core;

@:using(stx.schema.core.SType.STypeLift)
enum STypeSum{
  STData(t:Ref<DataType>);
  STAnon(t:Ref<AnonType>);
  STRecord(t:Ref<RecordType>);
  STGeneric(t:Ref<GenericType>);
  STUnion(t:Ref<UnionType>);
  STLink(t:Ref<LinkType>);
  STEnum(t:Ref<EnumType>);
  STLazy(f:Ref<LazyType>);
  STMono;
}
@:using(stx.schema.core.SType.STypeLift)
class STypeCls{
  public final data : STypeSum;
  public function new(data){
    this.data = data;
  }
  public function toString():String{
    return switch(data){
      case STData(t)       : t.toString(); 
      case STAnon(t)       : t.toString();
      case STRecord(t)     : t.toString();
      case STGeneric(t)    : t.toString();
      case STUnion(t)      : t.toString();
      case STLink(t)       : t.toString();
      case STEnum(t)       : t.toString();
      case STLazy(t)       : t.toString();
      case STMono          : "MONO";
    }
  }
  public var validation(get,never) : Validations;
  public function get_validation(){
    return SType._.fold(
      data,
      t   -> t.validation,
      t   -> t.validation,
      t   -> t.validation,
      t   -> t.validation,
      t   -> t.validation,
      t   -> t.validation,
      t   -> t.validation,
      t   -> t.validation,
      ()  -> Validations.unit()
    );
  }
  public var name(get,never) : String;
  public function get_name(){
    return SType._.fold(
      data,
      t   -> t.name,
      t   -> null,
      t   -> t.name,
      t   -> t.name,
      t   -> t.name,
      t   -> null,
      t   -> t.name,
      t   -> t.name,
      ()  -> null
    );
  }
  public var pack(get,never) : Cluster<String>;
  public function get_pack(){
    return SType._.fold(
      data,
      t   -> t.pack,
      t   -> Cluster.unit(),
      t   -> t.pack,
      t   -> t.pack,
      t   -> t.pack,
      t   -> Cluster.unit(),
      t   -> t.pack,
      t   -> t.pack,
      ()  -> Cluster.unit()
    );
  }
  public var debrujin(get,never) : Int;
  public function get_debrujin(){
    return SType._.fold(
      data,
      t   -> t.debrujin,
      t   -> t.debrujin,
      t   -> t.debrujin,
      t   -> t.debrujin,
      t   -> t.debrujin,
      t   -> t.debrujin,
      t   -> t.debrujin,
      t   -> t.debrujin,
      ()  -> -1
    );
  }
  public function register(state:TypeContext):SType{
    return switch(data){
      case STData(t)       : t.pop().register(state); 
      case STAnon(t)       : t.pop().register(state);
      case STRecord(t)     : t.pop().register(state);
      case STGeneric(t)    : t.pop().register(state);
      case STUnion(t)      : t.pop().register(state);
      case STLink(t)       : t.pop().register(state);
      case STEnum(t)       : t.pop().register(state);
      case STLazy(t)       : t.pop().register(state);
      case STMono          :
        __.log().trace("PPPPPL"); 
        new STypeCls(STMono);
    }
  }
  public function identity():Identity{
    return switch(data){
      case STData(t)       : t.pop().identity(); 
      case STAnon(t)       : t.pop().identity();
      case STRecord(t)     : t.pop().identity();
      case STGeneric(t)    : t.pop().identity();
      case STUnion(t)      : t.pop().identity();
      case STLink(t)       : t.pop().identity();
      case STEnum(t)       : t.pop().identity();
      case STLazy(t)       : t.pop().identity();
      case STMono          :
        //throw 'abstract identity'; 
        Identity.fromIdent(Ident.make('TMono'));
    }
  }
  public var fields(get,never):Cluster<Field>;

  public function get_fields(){
    return switch(this.data){
      case STAnon(t)      : __.option(t.pop().fields.pop()).defv(Cluster.unit());
      case STRecord(t)    : __.option(t.pop().fields.pop()).defv(Cluster.unit());
      default             : Cluster.unit();
    }
  }
}
@:forward abstract SType(STypeCls) from STypeCls to STypeCls{
  static public var _(default,never) = STypeLift;  
  public function new(self) this = self;
  @:noUsing static public function lift(self:STypeCls):SType return new SType(self);
  @:noUsing static public function make(self:STypeSum):SType{
    return lift(new STypeCls(self));
  }
  public function prj():STypeCls return this;
  private var self(get,never):SType;
  private function get_self():SType return lift(this);

  static public function Array(self:SType):SType{
    return stx.schema.core.type.term.TypeArray.make(self).toSType();
  } 
  static public function Bool():SType{
    return new stx.schema.core.type.term.TypeBool().toSType();
  }
  static public function Float():SType{
    return new stx.schema.core.type.term.TypeFloat().toSType();
  }
  static public function Int():SType{
    return new stx.schema.core.type.term.TypeInt().toSType();
  }
  static public function String():SType{
    return new stx.schema.core.type.term.TypeString().toSType();
  }
  static public function Null(self:SType):SType{
    return stx.schema.core.type.term.TypeNull.make(self).toSType();
  }
  static public function Mono():SType{
    return STMono;
  }
  // static public function Into(self:Ident,debrujin):SType{
  //   return stx.schema.core.type.term.IntoSType.make(self,debrujin).toSType();
  // }
  @:from static public function fromSTypeSum(self:STypeSum):SType{
    return lift(new STypeCls(self));
  }
  static public function LeafType(name,pack):SType{
    return _.LeafType(name,pack).toSType();
  }
  static public function RecordType(name,pack,fields):SType{
    return _.RecordType(name,pack,fields).toSType();
  }
  static public function AnonType(fields):SType{
    return _.AnonType(fields).toSType();
  }
  static public function GenericType(name,pack,inner):SType{
    return _.GenericType(name,pack,inner).toSType();
  }
  static public function LinkType(into,relation,from):SType{
    return _.LinkType(into,relation,from).toSType();
  }
  static public function UnionType(name,pack,lhs,rhs):SType{
    return _.UnionType(name,pack,lhs,rhs).toSType();
  }
}
class STypeLift{
  static public inline function fold<Z>(self:STypeSum, data:DataType -> Z, anon : AnonType -> Z, record : RecordType -> Z, generic : GenericType -> Z, union : UnionType -> Z, link : LinkType -> Z, _enum : EnumType -> Z, lazy : LazyType -> Z, mono : Void -> Z) : Z {
    return switch(self){
      case STData(t)       : data(t.pop()); 
      case STAnon(t)       : anon(t.pop());
      case STRecord(t)     : record(t.pop());
      case STGeneric(t)    : generic(t.pop());
      case STUnion(t)      : union(t.pop());
      case STLink(t)       : link(t.pop());
      case STEnum(t)       : _enum(t.pop());
      case STLazy(t)       : lazy(t.pop());
      case STMono          : mono();
    }
  }
  static public function get_link(self:SType):Option<LinkType>{
    return switch(self.data){
      case STLink(t) : Some(t.pop());
      default       : None;
    }
  }
  static public function is_terminal(self:SType){
    return switch(self.data){
      case STData(_) : true;
      case STAnon(_) : true;
      case STLazy(f) : is_terminal(f.pop().type);
      default       : false;
    }
  }
  static public function is_anon(self:SType){
    return switch(self.data){
      case STAnon(_) : true;
      default : false;
    }
  }
  static public function is_link(self:SType){
    return switch(self.data){
      case STLink(_) : true;
      default : false;
    }
  }
  static public function get_inverse(self:SType):Option<SType>{
    return switch(self.data){
      case STLink(t) : Some(t.pop().lookup());
      default        : None;
    }
  }
  static public function LeafType(name,pack){
    return stx.schema.core.type.LeafType.make(name,pack);
  }
  static public function RecordType(name,pack,fields){
    return stx.schema.core.type.RecordType.make(name,pack,fields);
  }
  static public function AnonType(fields){
    return stx.schema.core.type.AnonType.make(fields);
  }
  static public function GenericType(name,pack,inner){
    return stx.schema.core.type.GenericType.make(name,pack,inner);
  }
  static public function LinkType(into,relation,from){
    return stx.schema.core.type.LinkType.make(into,relation,from);
  }
  static public function UnionType(name,pack,lhs,rhs){
    return stx.schema.core.type.UnionType.make(name,pack,lhs,rhs);
  }
  static public function main(type:SType,state:GTypeContext):Void{
    switch(type.data){
      case STData(t)     :
      case STRecord(t)   : t.pop().main(state);
      case STGeneric(t)  : t.pop().main(state);
      case STUnion(t)    : t.pop().main(state);
      case STLink(t)     : t.pop().main(state);
      case STEnum(t)     : t.pop().main(state);
      case STLazy(f)     : main(f.pop().type,state);
      case STAnon(t)     : t.pop().main(state);
      case STMono        : 
    }   
  }
  static public function leaf(self:SType,state:GTypeContext):Void{
    switch(self.data){
      case STData(t)     :
      case STRecord(t)   : t.pop().leaf(state);
      case STGeneric(t)  : t.pop().leaf(state);
      case STUnion(t)    : t.pop().leaf(state);
      case STLink(t)     : t.pop().leaf(state);
      case STEnum(t)     : t.pop().leaf(state);
      case STLazy(f)     : leaf(f.pop().type,state);
      case STAnon(t)     : t.pop().leaf(state);
      case STMono        : 
    }   
  }
  static public function getTypePath(self:SType){
    return switch(self.data){
      case STData(t)     : Some(t.pop().toGTypePath());
      case STRecord(t)   : Some(t.pop().toGTypePath());
      case STGeneric(t)  : Some(t.pop().toGTypePath());
      case STUnion(t)    : Some(t.pop().toGTypePath());
      case STLink(t)     : None;
      case STEnum(t)     : Some(t.pop().toGTypePath());
      case STLazy(f)     : getTypePath(f.pop().type);
      case STAnon(t)     : None;
      case STMono        : None;
    }
  }
  static public function getFieldComplexTypesWane(self:SType){
    return self.fields.map(
      (field) -> __.g().field().Make(
        field.name,
        ftype -> ftype.Var(
          field.type.get_link().fold(
            link -> switch(link.relation){
              case HAS_MANY : __.g().ctype().Path(
                path -> path.Make(
                  'Cluster',['stx'], null,
                  //[__.g().ctype().Anonymous(link.into.getFieldComplexTypesWane()).toTypeParam()]
                  [__.g().ctype().fromString('stx.schema.ID').toTypeParam()]
                )
              );
              default : __.g().ctype().fromString('stx.schema.ID');
            },
            () -> return switch(getTypePath(field.type)){
              case Some(tpath) : tpath.toComplexType();
              default          : throw E_Schema_AttemptingToDefineUnsupportedType(field.type);
            }
          )
        ),
        acc -> [acc.Public(),acc.Final()]
      )
    );
  }
}
/**
  switch(self){
    case TData(t)     :
    case TAnon(t)     :
    case TRecord(t)   :
    case TGeneric(t)  :
    case TUnion(t)    :
    case STLink(t)     :
    case TEnum(t)     :
    case TLazy(f)     :
    case TMono        :
  }
**/