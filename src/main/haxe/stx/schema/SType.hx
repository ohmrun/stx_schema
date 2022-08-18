package stx.schema;

@:using(stx.schema.SType.STypeLift)
enum STypeSum{
  STMono;
  STLazy(f:Ref<LazyType>);
  STScalar(t:Ref<ScalarType>);
  STEnum(t:Ref<EnumType>);
  STAnon(t:Ref<AnonType>);
  STRecord(t:Ref<RecordType>);
  STGeneric(t:Ref<GenericType>);
  STUnion(t:Ref<UnionType>);
  STLink(t:Ref<LinkType>);
}
@:using(stx.schema.SType.STypeLift)
class STypeCls{
  public function get_data(){
    return this.data;
  }
  public final data : STypeSum;
  public function new(data){
    this.data = data;
  }
  public function toString():String{
    return switch(data){
      case STScalar(t)       : t.toString(); 
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
  public var identity(get,never) : Identity;
  public function get_identity():Identity{
    return switch(data){
      case STScalar(t)        : t.identity; 
      case STAnon(t)          : t.identity;
      case STRecord(t)        : t.identity;
      case STGeneric(t)       : t.identity;
      case STUnion(t)         : t.identity;
      case STLink(t)          : t.identity;
      case STEnum(t)          : t.identity;
      case STLazy(t)          : t.identity;
      case STMono             :
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

  static public function Array(register,self:SType):SType{
    return stx.schema.type.term.TypeArray.make(register,self).toSType();
  } 
  static public function Bool(register):SType{
    return new stx.schema.type.term.TypeBool(register).toSType();
  }
  static public function Float(register):SType{
    return new stx.schema.type.term.TypeFloat(register).toSType();
  }
  static public function Int(register):SType{
    return new stx.schema.type.term.TypeInt(register).toSType();
  }
  static public function String(register):SType{
    return new stx.schema.type.term.TypeString(register).toSType();
  }
  static public function Null(register,self:SType):SType{
    return stx.schema.type.term.TypeNull.make(register,self).toSType();
  }
  static public function Mono():SType{
    return STMono;
  }
  // static public function Into(self:Ident,debrujin):SType{
  //   return stx.schema.type.term.IntoSType.make(self,debrujin).toSType();
  // }
  @:from static public function fromSTypeSum(self:STypeSum):SType{
    return lift(new STypeCls(self));
  }
  static public function LeafType(register,ident,ctype,?validation,?meta):SType{
    return _.LeafType(register,ident,ctype,validation,meta).toSType();
  }
  static public function RecordType(register,name,pack,fields,?validation,?meta):SType{
    return _.RecordType(register,name,pack,fields,validation,meta).toSType();
  }
  static public function AnonType(register,fields,?validation,?meta):SType{
    return _.AnonType(register,fields,validation,meta).toSType();
  }
  static public function GenericType(register,name,pack,inner):SType{
    return _.GenericType(register,name,pack,inner).toSType();
  }
  static public function LinkType(register,into,relation,from):SType{
    return _.LinkType(register,into,relation,from).toSType();
  }
  static public function UnionType(register,name,pack,lhs,rhs):SType{
    return _.UnionType(register,name,pack,lhs,rhs).toSType();
  }
  public function get_enum_value_index(){
    return EnumValue.lift(this.data).index;
  }
}
class STypeLift{
  static public inline function fold<Z>(self:STypeSum, data:ScalarType -> Z, anon : AnonType -> Z, record : RecordType -> Z, generic : GenericType -> Z, union : UnionType -> Z, link : LinkType -> Z, _enum : EnumType -> Z, lazy : LazyType -> Z, mono : Void -> Z) : Z {
    return switch(self){
      case STScalar(t)       : data(t.pop()); 
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
  static public function is_scalar(self:SType){
    return switch(self.data){
      case STScalar(_)  : true;
      case STLazy(f)    : is_scalar(f.pop().type);
      default           : false;
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
      case STLink(t) : t.pop().lookup();
      default        : None;
    }
  }
  static public function LeafType(register,ident,ctype,?validation,?meta){
    return stx.schema.type.LeafType.make(ident,ctype,validation,meta);
  }
  static public function RecordType(register,name,pack,fields,?validation,?meta){
    return stx.schema.type.RecordType.make(register,Ident.make(name,pack),fields,validation,meta);
  }
  static public function AnonType(register,fields,?validation,?meta){
    return stx.schema.type.AnonType.make(register,fields,validation,meta);
  }
  static public function GenericType(register,ident,inner,?validation,?meta){
    return stx.schema.type.GenericType.make(register,ident,inner,validation,meta);
  }
  static public function LinkType(register,into,relation,from){
    return stx.schema.type.LinkType.make(register,into,relation,from);
  }
  static public function UnionType(register,name,pack,lhs,rhs){
    return stx.schema.type.UnionType.make(name,pack,lhs,rhs);
  }
  static public function getTypePath(self:SType){
    return switch(self.data){
      case STScalar(t)   : Some(t.pop().toGTypePath());
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
            () -> return switch(getTypePath(__.tracer()(field.type))){
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
  switch(type){
    case STScalar(t)     :
    case STAnon(t)     :
    case STRecord(t)   :
    case STGeneric(t)  :
    case STUnion(t)    :
    case STLink(t)     :
    case STEnum(t)     :
    case STLazy(f)     :
    case STMono        :
  }
**/