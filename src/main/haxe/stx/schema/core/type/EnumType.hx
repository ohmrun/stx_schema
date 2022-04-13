package stx.schema.core.type;

interface EnumTypeApi extends DataTypeApi  {
  final constructors : Cluster<String>;
}
class EnumTypeCls extends DataTypeCls implements EnumTypeApi{
  public final constructors : Cluster<String>;
  public function new(name,pack,constructors,?validation){
    super(name,pack,validation);
    this.constructors = constructors;
  }
  public function register(state:TypeContext){
    state.put(this.toType());
    return this.toType();
  }
  override public function toType():Type{
    return TEnum(Ref.pure(EnumType.lift(this)));
  }
  public function toString(){
    return this.identity().toString();
  } 
}
@:using(stx.schema.core.type.EnumType.EnumTypeLift)
@:forward abstract EnumType(EnumTypeApi) from EnumTypeApi to EnumTypeApi{
  public function new(self) this = self;
  @:noUsing static public function lift(self:EnumTypeApi):EnumType return new EnumType(self);

  public function prj():EnumTypeApi return this;
  private var self(get,never):EnumType;
  private function get_self():EnumType return lift(this);
  @:noUsing static public function make(name,pack,constructors,?validation){
    return lift(new EnumTypeCls(name,pack,constructors,validation));
  }
}
class EnumTypeLift{
  static public function leaf(self:EnumType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
  static public function main(self:EnumType,state:GTypeContext){
    return throw UNIMPLEMENTED;
  }
  static public function getTypeDefinition(self:EnumType){
    return __.g().type().Make(
      self.name,
      self.pack,
      ttype -> ttype.Abstract(
        ct -> ct.fromString('std.String'),
        ct -> [ct.fromString('std.String')],
        ct -> [ct.fromString('std.String')]
      ),
      fld -> self.constructors.map(
        str -> fld.Make(
          str,
          ftype -> ftype.Var(null,e -> e.Const(c -> c.String(str))),
          acc   -> []
        )
      ),
      [],
      meta -> [meta.Make(':enum')]
    );
  }
}