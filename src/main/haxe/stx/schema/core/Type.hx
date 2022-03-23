package stx.schema.core;

enum TypeDef{
  TData(t:Ref<DataType>);
  TAnon(t:Ref<AnonType>);
  TRecord(t:Ref<RecordType>);
  TGeneric(t:Ref<GenericType>);
  TUnion(t:Ref<UnionType>);
  TLink(t:Ref<LinkType>);
}
@:using(stx.schema.core.Type.TypeLift)
abstract Type(TypeDef) from TypeDef to TypeDef{
  static public var _(default,never) = TypeLift;
  public function new(self) this = self;
  static public function lift(self:TypeDef):Type  return new Type (self);

  public function prj():TypeDef return this;
  private var self(get,never):Type ;
  private function get_self():Type  return lift(this);

  static public function Array(self:Type):Type{
    return stx.schema.core.type.term.TypeArray.make(self).toType();
  }
  public var validation(get,never) : Validations;
  public function get_validation(){
    return _.fold(
      this,
      t -> t.validation,
      t -> t.validation,
      t -> t.validation,
      t -> t.validation,
      t -> t.validation,
      t -> t.validation
    );
  }
  public var name(get,never) : String;
  public function get_name(){
    return _.fold(
      this,
      t -> t.name,
      t -> null,
      t -> t.name,
      t -> t.name,
      t -> t.name,
      t -> null
    );
  }
  public var pack(get,never) : Cluster<String>;
  public function get_pack(){
    return _.fold(
      this,
      t -> t.pack,
      t -> Cluster.unit(),
      t -> t.pack,
      t -> t.pack,
      t -> t.pack,
      t -> Cluster.unit()
    );
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
}
class TypeLift{
  static public inline function fold<Z>(self:TypeDef, data:DataType -> Z, anon : AnonType -> Z, record : RecordType -> Z, generic : GenericType -> Z, union : UnionType -> Z, link : LinkType -> Z) : Z {
    return switch(self){
      case TData(t)       : data(t.pop()); 
      case TAnon(t)       : anon(t.pop());
      case TRecord(t)     : record(t.pop());
      case TGeneric(t)    : generic(t.pop());
      case TUnion(t)      : union(t.pop());
      case TLink(t)       : link(t.pop());
    }
  }
}