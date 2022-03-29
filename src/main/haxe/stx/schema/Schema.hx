package stx.schema;

enum SchemaSum{
  SchScalar(def:SchemaDeclaration);
  SchRecord(def:SchemaRecordDeclaration);
  SchEnum(def:SchemaEnumDeclaration);
  SchGeneric(def:SchemaGenericDeclaration);
  SchUnion(def:SchemaUnionDeclaration);
  SchLazy(fn:Void->Schema);
  SchType(type:Type);
}
@:using(stx.schema.Schema.SchemaLift)
abstract Schema(SchemaSum) from SchemaSum to SchemaSum{
  static public var _(default,never) = SchemaLift;
  public function new(self) this = self;
  static public function lift(self:SchemaSum):Schema return new Schema(self);

  public function prj():SchemaSum return this;
  private var self(get,never):Schema;
  private function get_self():Schema return lift(this);

  public var validation(get,never):Validations;
  private function get_validation():Validations{
    return _.fold(
      this,
      x -> x.validation,
      x -> x.validation,
      x -> x.validation,
      x -> x.validation,
      x -> x.validation,
      x -> x.validation
    );
  }
  public var name(get,never):String;
  private function get_name():String{
    return _.fold(
      this,
      x -> x.id.name,
      x -> x.id.name,
      x -> x.id.name,
      x -> x.id.name,
      x -> x.id.name,
      x -> x.identity().name
    );
  }
  public var pack(get,never):Cluster<String>;
  private function get_pack():Cluster<String>{
    return __.option(_.fold(
      this,
      x -> x.id.pack,
      x -> x.id.pack,
      x -> x.id.pack,
      x -> x.id.pack,
      x -> x.id.pack,
      x -> x.identity().pack
    )).def(() -> Cluster.unit());
  }
  public function identity():Identity{
    return _.fold(
      this,
      x -> x.identity(),
      x -> x.identity(),
      x -> x.identity(),
      x -> x.identity(),
      x -> x.identity(),
      x -> x.identity()
    );
  }
  public function resolve(state:Schemata):Schema{
    return _.fold(
      this,
      x -> x.resolve(state),
      x -> x.resolve(state),
      x -> x.resolve(state),
      x -> x.resolve(state),
      x -> x.resolve(state),
      x -> SchType(x)
    );
  }
  @:from static public function fromSchemaDeclaration(self:SchemaDeclarationDef):Schema{
    return lift(SchScalar(self));
  }
  @:from static public function fromSchemaGenericDeclaration(self:SchemaGenericDeclaration):Schema{
    return lift(SchGeneric(self));
  }
  static public function Array(ref):Schema{
    return lift(SchGeneric(stx.schema.term.SchemaArray.make(ref)));
  }
  static public function Bool():Schema{
    return lift(SchScalar(stx.schema.term.SchemaBool.make()));
  }
  static public function Float():Schema{
    return lift(SchScalar(stx.schema.term.SchemaFloat.make()));
  }
  static public function Int():Schema{
    return lift(SchScalar(stx.schema.term.SchemaInt.make()));
  }
  static public function Null(ref):Schema{
    return lift(SchGeneric(stx.schema.term.SchemaNull.make(ref)));
  }
  static public function String():Schema{
    return lift(SchScalar(stx.schema.term.SchemaString.make()));
  }
  public function toString(){
    return _.fold(
      this,
      x -> x.toString(),
      x -> x.toString(),
      x -> x.toString(),
      x -> x.toString(),
      x -> x.toString(),
      x -> x.toString()
    );
  }
}
class SchemaLift{
  static public inline function fold<Z>(self:SchemaSum,scalar : SchemaDeclaration -> Z, record : SchemaRecordDeclaration  -> Z, enm : SchemaEnumDeclaration -> Z, generic : SchemaGenericDeclaration -> Z, union : SchemaUnionDeclaration -> Z, type : Type -> Z) : Z {
    return switch(self){
      case SchScalar(def)   : scalar(def);
      case SchRecord(def)   : record(def);
      case SchEnum(def)     : enm(def);
      case SchGeneric(def)  : generic(def);
      case SchUnion(def)    : union(def);
      case SchLazy(f)       : fold(f(),scalar,record,enm,generic,union,type); 
      case SchType(def)     : type(def);
    }
  }
}