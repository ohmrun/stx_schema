package stx.schema.core;

@:using(stx.schema.core.Type.TypeLift)
enum TypeSum{
  TData(t:Ref<DataType>);
  TAnon(t:Ref<AnonType>);
  TRecord(t:Ref<RecordType>);
  TGeneric(t:Ref<GenericType>);
  TUnion(t:Ref<UnionType>);
  TLink(t:Ref<LinkType>);
  TEnum(t:Ref<EnumType>);
  TLazy(f:Ref<LazyType>);
  TMono;
}
@:using(stx.schema.core.Type.TypeLift)
class TypeCls{
  public final data : TypeSum;
  public function new(data){
    this.data = data;
  }
  public function toString():String{
    return switch(data){
      case TData(t)       : t.toString(); 
      case TAnon(t)       : t.toString();
      case TRecord(t)     : t.toString();
      case TGeneric(t)    : t.toString();
      case TUnion(t)      : t.toString();
      case TLink(t)       : t.toString();
      case TEnum(t)       : t.toString();
      case TLazy(t)       : t.toString();
      case TMono          : "MONO";
    }
  }
  public var validation(get,never) : Validations;
  public function get_validation(){
    return Type._.fold(
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
    return Type._.fold(
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
    return Type._.fold(
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
    return Type._.fold(
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
  public function register(state:TypeContext):Type{
    return switch(data){
      case TData(t)       : t.pop().register(state); 
      case TAnon(t)       : t.pop().register(state);
      case TRecord(t)     : t.pop().register(state);
      case TGeneric(t)    : t.pop().register(state);
      case TUnion(t)      : t.pop().register(state);
      case TLink(t)       : t.pop().register(state);
      case TEnum(t)       : t.pop().register(state);
      case TLazy(t)       : t.pop().register(state);
      case TMono          :
        __.log().trace("PPPPPL"); 
        new TypeCls(TMono);
    }
  }
  public function identity():Identity{
    return switch(data){
      case TData(t)       : t.pop().identity(); 
      case TAnon(t)       : t.pop().identity();
      case TRecord(t)     : t.pop().identity();
      case TGeneric(t)    : t.pop().identity();
      case TUnion(t)      : t.pop().identity();
      case TLink(t)       : t.pop().identity();
      case TEnum(t)       : t.pop().identity();
      case TLazy(t)       : t.pop().identity();
      case TMono          :
        //throw 'abstract identity'; 
        Identity.fromIdent(Ident.make('TMono'));
    }
  }
  public var fields(get,never):Cluster<Field>;

  public function get_fields(){
    return switch(this.data){
      case TAnon(t)     : __.option(t.pop().fields.pop()).defv(Cluster.unit());
      case TRecord(t)   : __.option(t.pop().fields.pop()).defv(Cluster.unit());
      default           : Cluster.unit();
    }
  }
}
@:forward abstract Type(TypeCls) from TypeCls to TypeCls{
  static public var _(default,never) = TypeLift;  
  public function new(self) this = self;
  static public function lift(self:TypeCls):Type return new Type(self);
  static public function make(self:TypeSum):Type{
    return lift(new TypeCls(self));
  }
  public function prj():TypeCls return this;
  private var self(get,never):Type;
  private function get_self():Type return lift(this);

  static public function Array(self:Type):Type{
    return stx.schema.core.type.term.TypeArray.make(self).toType();
  } 
  static public function Bool():Type{
    return new stx.schema.core.type.term.TypeBool().toType();
  }
  static public function Float():Type{
    return new stx.schema.core.type.term.TypeFloat().toType();
  }
  static public function Int():Type{
    return new stx.schema.core.type.term.TypeInt().toType();
  }
  static public function String():Type{
    return new stx.schema.core.type.term.TypeString().toType();
  }
  static public function Null(self:Type):Type{
    return stx.schema.core.type.term.TypeNull.make(self).toType();
  }
  static public function Mono():Type{
    return TMono;
  }
  // static public function Into(self:Ident,debrujin):Type{
  //   return stx.schema.core.type.term.IntoType.make(self,debrujin).toType();
  // }
  @:from static public function fromTypeSum(self:TypeSum):Type{
    return lift(new TypeCls(self));
  }
  static public function LeafType(name,pack):Type{
    return _.LeafType(name,pack).toType();
  }
  static public function RecordType(name,pack,fields):Type{
    return _.RecordType(name,pack,fields).toType();
  }
  static public function AnonType(fields):Type{
    return _.AnonType(fields).toType();
  }
  static public function GenericType(name,pack,inner):Type{
    return _.GenericType(name,pack,inner).toType();
  }
  static public function LinkType(into,relation,from):Type{
    return _.LinkType(into,relation,from).toType();
  }
  static public function UnionType(name,pack,lhs,rhs):Type{
    return _.UnionType(name,pack,lhs,rhs).toType();
  }
}
class TypeLift{
  static public inline function fold<Z>(self:TypeSum, data:DataType -> Z, anon : AnonType -> Z, record : RecordType -> Z, generic : GenericType -> Z, union : UnionType -> Z, link : LinkType -> Z, _enum : EnumType -> Z, lazy : LazyType -> Z, mono : Void -> Z) : Z {
    return switch(self){
      case TData(t)       : data(t.pop()); 
      case TAnon(t)       : anon(t.pop());
      case TRecord(t)     : record(t.pop());
      case TGeneric(t)    : generic(t.pop());
      case TUnion(t)      : union(t.pop());
      case TLink(t)       : link(t.pop());
      case TEnum(t)       : _enum(t.pop());
      case TLazy(t)       : lazy(t.pop());
      case TMono          : mono();
    }
  }
  static public function get_link(self:Type):Option<LinkType>{
    return switch(self.data){
      case TLink(t) : Some(t.pop());
      default       : None;
    }
  }
  static public function is_terminal(self:Type){
    return switch(self.data){
      case TData(_) : true;
      case TAnon(_) : true;
      case TLazy(f) : is_terminal(f.pop().type);
      default       : false;
    }
  }
  static public function is_anon(self:Type){
    return switch(self.data){
      case TAnon(_) : true;
      default : false;
    }
  }
  static public function is_link(self:Type){
    return switch(self.data){
      case TLink(_) : true;
      default : false;
    }
  }
  static public function get_inverse(self:Type):Option<Type>{
    return switch(self.data){
      case TLink(t) : Some(t.pop().lookup());
      default       : None;
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
  static public function main(type:Type,state:GTypeContext):Void{
    switch(type.data){
      case TData(t)     :
      case TRecord(t)   : t.pop().main(state);
      case TGeneric(t)  : t.pop().main(state);
      case TUnion(t)    : t.pop().main(state);
      case TLink(t)     : t.pop().main(state);
      case TEnum(t)     : t.pop().main(state);
      case TLazy(f)     : main(f.pop().type,state);
      case TAnon(t)     : t.pop().main(state);
      case TMono        : 
    }   
  }
  static public function leaf(self:Type,state:GTypeContext):Void{
    switch(self.data){
      case TData(t)     :
      case TRecord(t)   : t.pop().leaf(state);
      case TGeneric(t)  : t.pop().leaf(state);
      case TUnion(t)    : t.pop().leaf(state);
      case TLink(t)     : t.pop().leaf(state);
      case TEnum(t)     : t.pop().leaf(state);
      case TLazy(f)     : leaf(f.pop().type,state);
      case TAnon(t)     : t.pop().leaf(state);
      case TMono        : 
    }   
  }
  static public function getTypePath(self:Type){
    return switch(self.data){
      case TData(t)     : Some(t.pop().toTypePath());
      case TRecord(t)   : Some(t.pop().toTypePath());
      case TGeneric(t)  : Some(t.pop().toTypePath());
      case TUnion(t)    : Some(t.pop().toTypePath());
      case TLink(t)     : None;
      case TEnum(t)     : Some(t.pop().toTypePath());
      case TLazy(f)     : getTypePath(f.pop().type);
      case TAnon(t)     : None;
      case TMono        : None;
    }
  }
  static public function getFieldComplexTypesWane(self:Type){
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
    case TLink(t)     :
    case TEnum(t)     :
    case TLazy(f)     :
    case TMono        :
  }
**/