package stx.schema.core;

enum TypeDef{
  TData(t:DataType);
  TAnon(t:AnonType);
  TRecord(t:RecordType);
  TGeneric(t:GenericType);
  TUnion(t:UnionType);
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
      t -> t.name
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
      t -> t.pack
    );
  }
  // static public function String():Schema{
  //   return new stx.schema.types.SchemaString();
  // }
  // static public function Int():Schema{
  //   return new stx.schema.types.SchemaInt();
  // }
  // static public function Null(self:SchemaRef):Schema{
  //   return stx.schema.types.SchemaNull.make(self);
  // }
}
class TypeLift{
  static public inline function fold<Z>(self:TypeDef, data:DataType -> Z, anon : AnonType -> Z, record : RecordType -> Z, generic : GenericType -> Z, union : UnionType -> Z) : Z {
    return switch(self){
      case TData(t)       : data(t); 
      case TAnon(t)       : anon(t);
      case TRecord(t)     : record(t);
      case TGeneric(t)    : generic(t);
      case TUnion(t)      : union(t);
    }
  }
}