package stx.schema;

enum SchemaSum{
  SchScalar(def:SchemaDeclarationDef);
  SchRecord(def:SchemaRecordDeclarationDef);
  SchEnum(def:SchemaEnumDeclaration);
  SchGeneric(def:SchemaGenericDeclaration);
  SchUnion(def:SchemaUnionDeclaration);
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
      x -> x.name,
      x -> x.name,
      x -> x.name,
      x -> x.name,
      x -> x.name,
      x -> x.name
    );
  }
  public var pack(get,never):Cluster<String>;
  private function get_pack():Cluster<String>{
    return __.option(_.fold(
      this,
      x -> x.pack,
      x -> x.pack,
      x -> x.pack,
      x -> x.pack,
      x -> x.pack,
      x -> x.pack

    )).def(() -> Cluster.unit());
}
  @:from static public function fromSchemaDeclaration(self:SchemaDeclarationDef):Schema{
    return lift(SchScalar(self));
  }
  @:from static public function fromSchemaGenericDeclaration(self:SchemaGenericDeclaration):Schema{
    return lift(SchGeneric(self));
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
      case SchType(def)     : type(def);
    }
  }
}