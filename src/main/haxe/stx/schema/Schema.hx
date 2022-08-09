package stx.schema;

enum SchemaSum{
  SchLazy(fn:Void->Schema);
  SchScalar(def:DeclareScalarSchema);
  SchRecord(def:DeclareRecordSchema);
  SchEnum(def:DeclareEnumSchema);
  SchGeneric(def:DeclareGenericSchema);
  SchUnion(def:DeclareUnionSchema);
}
@:using(stx.schema.Schema.SchemaLift)
abstract Schema(SchemaSum) from SchemaSum to SchemaSum{
  static public var _(default,never) = SchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:SchemaSum):Schema return new Schema(self);

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
      x -> x.validation
    );
  }
  public var identity(get,never):Identity;
  private function get_identity():Identity{
    return _.fold(
      this,
      x -> x.identity,
      x -> x.identity,
      x -> x.identity,
      x -> x.identity,
      x -> x.identity
    );
  }
  // public function resolve(state:TyperContext):Future<LVar<Schema>>{
  //   return _.fold(
  //     this,
  //     x -> x.resolve(state),
  //     x -> x.resolve(state),
  //     x -> DeclareEnumSchema._.resolve(x,state),
  //     x -> x.resolve(state),
  //     x -> x.resolve(state)
  //   );
  // }
  @:from static public function fromRecordObject(self:{ name : String, ?pack : Array<String>, ?meta : PExpr<Primitive>, fields : { ?properties : Map<String,DeclareProperty> , ?attributes : Map<String,DeclareAttribute> }, ?validation : Validations}){
    return stx.schema.declare.DeclareRecordSchema.make0(
        self.name,self.pack,
        Procurements.fromObject(self.fields),
        self.meta,
        self.validation
      ).toSchema();
  }
  @:from static public function fromScalarObject(self:{ name : String, ?pack : Array<String>, ?meta : PExpr<Primitive>, ?ctype : GComplexType, ?validation : Validations}){
    final ident = Ident.make(self.name,self.pack);
    final ctype = __.option(self.ctype).def(() -> __.g().ctype().Path(p -> p.fromIdent(ident)));
    final meta  = __.option(self.meta).defv(PEmpty);
    return fromDeclareScalarSchema(
        DeclareScalarSchema.make(
          Identity.fromIdent(ident),
          ctype,
          meta,
          self.validation
      )
    );
  }
  @:from static public function fromGenericObject(self:{name : String, ?pack : Array<String>, ?validation : Validations, ?type : Schema }){
    return DeclareGenericSchema.make(Ident.make(self.name,self.pack),self.type,self.validation).toSchema();
  }
  @:from static public function fromDeclareScalarSchema(self:DeclareScalarSchemaApi):Schema{
    return lift(SchScalar(self));
  }
  @:from static public function fromDeclareGenericSchema(self:DeclareGenericSchema):Schema{
    return lift(SchGeneric(self));
  }
  static public function Array(ref):Schema{
    return lift(SchGeneric(stx.schema.declare.term.SchemaArray.make(ref)));
  }
  static public function Bool():Schema{
    return lift(SchScalar(stx.schema.declare.term.SchemaBool.make()));
  }
  static public function Float():Schema{
    return lift(SchScalar(stx.schema.declare.term.SchemaFloat.make()));
  }
  static public function Int():Schema{
    return lift(SchScalar(stx.schema.declare.term.SchemaInt.make()));
  }
  static public function Null(ref):Schema{
    return lift(SchGeneric(stx.schema.declare.term.SchemaNull.make(ref)));
  }
  static public function String():Schema{
    return lift(SchScalar(stx.schema.declare.term.SchemaString.make()));
  }
  public function toString(){
    return _.fold(
      this,
      x -> x.toString(),
      x -> x.toString(),
      x -> x.toString(),
      x -> x.toString(),
      x -> x.toString()
    );
  }
}
class SchemaLift{
  static public inline function fold<Z>(self:SchemaSum,scalar : DeclareScalarSchema -> Z, record : DeclareRecordSchema  -> Z, enm : DeclareEnumSchema -> Z, generic : DeclareGenericSchema -> Z, union : DeclareUnionSchema -> Z) : Z {
    return switch(self){
      case SchScalar(def)   : scalar(def);
      case SchRecord(def)   : record(def);
      case SchEnum(def)     : enm(def);
      case SchGeneric(def)  : generic(def);
      case SchUnion(def)    : union(def);
      case SchLazy(f)       : fold(f(),scalar,record,enm,generic,union);
    }
  }
  /**
    Creates a declaration that declares the Schema.
  **/
  static public inline function denote(self:SchemaSum):GExpr{
    var v = self.lift();

    return __.g().expr().New(
      _ -> 'stx.schema.Schema',
      args  -> [
        args.Call(
          func -> func.Field(
            expr -> expr.FieldPath('SchemaSum',['stx','schema','Schema']),
            v.ctr()
          ),
          args -> [
            switch(v.ctr()){
              case "SchScalar"  : DeclareSchema._.denote(v.params()[0]);
              case "SchRecord"  : DeclareRecordSchema._.denote(v.params()[0]);
              case "SchEnum"    : DeclareEnumSchema._.denote(v.params()[0]);
              case "SchGeneric" : DeclareGenericSchema._.denote(v.params()[0]);
              case "SchUnion"   : DeclareUnionSchema._.denote(v.params()[0]);
              case "SchLazy"    : denote(v.params()[0]());
              case x            : throw E_Makro_EnumConstructorNotFound(v,x);
            }
          ] 
        )
      ]
    );
  }
}