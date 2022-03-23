package stx.schema.core;

@:using(stx.schema.core.Type.TypeLift)
enum TypeSum{
  TData(t:Ref<DataType>);
  TAnon(t:Ref<AnonType>);
  TRecord(t:Ref<RecordType>);
  TGeneric(t:Ref<GenericType>);
  TUnion(t:Ref<UnionType>);
  TLink(t:Ref<LinkType>);
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
      ()  -> null
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
      ()  -> -1
    );
  }
  public function register(){
    return switch(data){
      case TData(t)       : t.pop().register(); 
      case TAnon(t)       : t.pop().register();
      case TRecord(t)     : t.pop().register();
      case TGeneric(t)    : t.pop().register();
      case TUnion(t)      : t.pop().register();
      case TLink(t)       : t.pop().register();
      case TMono          : 
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
  static public function mono():Type{
    return TMono;
  }
  static public function Into(self:Ident,debrujin):Type{
    return stx.schema.core.type.term.IntoType.make(self,debrujin).toType();
  }
  @:from static public function fromTypeSum(self:TypeSum):Type{
    return lift(new TypeCls(self));
  }
}
class TypeLift{
  static public inline function fold<Z>(self:TypeSum, data:DataType -> Z, anon : AnonType -> Z, record : RecordType -> Z, generic : GenericType -> Z, union : UnionType -> Z, link : LinkType -> Z, mono : Void -> Z) : Z {
    return switch(self){
      case TData(t)       : data(t.pop()); 
      case TAnon(t)       : anon(t.pop());
      case TRecord(t)     : record(t.pop());
      case TGeneric(t)    : generic(t.pop());
      case TUnion(t)      : union(t.pop());
      case TLink(t)       : link(t.pop());
      case TMono          : mono();
    }
  }
}