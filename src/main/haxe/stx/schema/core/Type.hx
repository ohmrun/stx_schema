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
  public function is_anon(){
    return switch(data){
      case TAnon(_) : true;
      default : false;
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
  static public function leaf(type:Type,state:GTypeContext):Void{
    switch(type.data){
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
  static public function toComplexType(self:Type,state:GTypeContext):Res<GComplexType,SchemaFailure>{
    return switch(self.data){
      case TData(t)     : t.pop().toComplexType(state);
      case TAnon(t)     : t.pop().toComplexType(state);
      case TRecord(t)   : t.pop().toComplexType(state);
      case TGeneric(t)  : t.pop().toComplexType(state);
      case TUnion(t)    : t.pop().toComplexType(state);
      case TLink(t)     : t.pop().toComplexType(state);
      case TEnum(t)     : t.pop().toComplexType(state);
      case TLazy(f)     : f.pop().toComplexType(state);
      case TMono        : __.accept(__.g().type_path().Make('Unknown',[]).toComplexType());
    }
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