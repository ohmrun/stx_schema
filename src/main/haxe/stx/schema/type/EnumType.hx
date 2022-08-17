package stx.schema.type;

interface EnumTypeApi extends DataTypeApi  {
  final constructors : Cluster<String>;
  final ident        : Ident;
}
class EnumTypeCls extends NominativeTypeCls implements EnumTypeApi{
  public final constructors : Cluster<String>;
  public function new(ident,constructors,?validation,?meta){
    super(ident,validation,meta);
    this.constructors = constructors;
  }
  // public function register(state:TypeContext){
  //   state.put(this.toSType());
  //   return this.toSType();
  // }
  public function toSType():SType{
    return STEnum(Ref.wrap((this:EnumType)));
  }
  public function toString(){ 
    return this.identity.toString();
  }
}
@:using(stx.schema.type.EnumType.EnumTypeLift)
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
  static public function getTypeDefinition(self:EnumType){
    return __.g().type().Make(
      self.ident.name,
      self.ident.pack,
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