package stx.schema.type;

interface ScalarTypeApi extends NominativeTypeApi{
  final ctype : GComplexType;
}
class ScalarTypeCls extends NominativeTypeCls implements ScalarTypeApi{
  public final ctype : GComplexType;
  static public function make(register,ident,ctype,?validation,?meta){
    return new ScalarTypeCls(register,ident,ctype,validation,meta);
  }
  public function new(register,ident,ctype,?validation,?meta){
    super(register,ident,validation,meta);
    this.ctype = ctype;
  }
  public function toSType(){
    return SType.make(STScalar(Ref.wrap((this:ScalarType))));
  }
}
// abstract class ScalarTypeBase extends ScalarTypeCls{

// }
@:using(stx.schema.type.ScalarType.ScalarTypeLift)
@:forward abstract ScalarType(ScalarTypeApi) from ScalarTypeApi to ScalarTypeApi{
  static public var _(default,never) = ScalarTypeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:ScalarTypeApi):ScalarType return new ScalarType(self);

  @:noUsing static public function make(register,ident,ctype,?validation,?meta){
    return lift(new ScalarTypeCls(register,ident,ctype,validation,meta));
  }
  public function prj():ScalarTypeApi return this;
  private var self(get,never):ScalarType;
  private function get_self():ScalarType return lift(this);

  public function copy(?register,?ident,?ctype,?validation,?meta){
    return make(
      __.option(register).defv(this.register),
      __.option(ident).defv(this.ident),
      __.option(ctype).defv(this.ctype),
      __.option(validation).defv(this.validation),
      __.option(meta).defv(this.meta)
    );
  }
}
class ScalarTypeLift{
  
}