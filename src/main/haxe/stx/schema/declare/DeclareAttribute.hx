
package stx.schema.declare;

typedef DeclareAttributeDef = DeclarePropertyDef & {
  final relation    : RelationType; 
  final ?inverse    : Null<String>;
}
@:forward abstract DeclareAttribute(DeclareAttributeDef) from DeclareAttributeDef to DeclareAttributeDef{
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareAttributeDef):DeclareAttribute return new DeclareAttribute(self);
  @:noUsing static public function make(type,relation,?meta,?inverse,?validation){
    return lift({ type : type,relation : relation,meta : meta, validation : validation, inverse : inverse  });
  }
  public function prj():DeclareAttributeDef return this;
  private var self(get,never):DeclareAttribute;
  private function get_self():DeclareAttribute return lift(this);

  public function with_type(ref:SchemaRef){
    return lift({
      validation  : this.validation,
      relation    : this.relation,
      inverse     : this.inverse,
      meta        : this.meta,
      type        : ref
    });
  }
  public function procure(name:String):ProcureAttribute{
    return ProcureAttribute.make(name,this.type,this.relation,this.inverse,this.meta,this.validation);
  }
  @:from static public function fromObject(self:{ type : SchemaRef, ?meta : PExpr<Primitive>, ?validation : Validations, relation : RelationType, ?inverse : Null<String> }){
    return return lift({
      validation  : self.validation,
      relation    : self.relation,
      inverse     : self.inverse,
      meta        : __.option(self.meta).defv(PEmpty),
      type        : self.type
    });
  }
  @:from static public function fromObjectI(self:{ type : Ident, ?meta : PExpr<Primitive>, ?validation : Validations, relation : RelationType, ?inverse : Null<String> }){
    return return lift({
      validation  : self.validation,
      relation    : self.relation,
      inverse     : self.inverse,
      meta        : __.option(self.meta).defv(PEmpty),
      type        : SchemaRef.fromIdent(self.type)
    });
  } 
  @:from static public function fromObjectII(self:{ type : Ident, ?meta : PExprDef<Primitive>, ?validation : Validations, relation : RelationType, ?inverse : Null<String> }){
    return return lift({
      validation  : self.validation,
      relation    : self.relation,
      inverse     : self.inverse,
      meta        : __.option(self.meta).defv(PEmpty),
      type        : SchemaRef.fromIdent(self.type)
    });
  }
  @:from static public function fromObjectIII(self:{ type : Ident, relation : RelationType, ?inverse : Null<String> }){
    return return fromObjectII({
      validation  : Validations.unit(),
      relation    : self.relation,
      inverse     : self.inverse,
      meta        : PEmpty,
      type        : self.type
    });
  } 
}