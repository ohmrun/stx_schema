package stx.schema.type;

interface NativeTypeApi extends NominativeTypeApi{
  final ctype : GComplexType;
}
class NativeTypeCls extends NominativeTypeCls implements NativeTypeApi{
  public final ctype : GComplexType;
  static public function make(ident,ctype,?validation,?meta){
    return new NativeTypeCls(ident,ctype,validation,meta);
  }
  public function new(ident,ctype,?validation,?meta){
    super(ident,validation,meta);
    this.ctype = ctype;
  }
  public function toSType(){
    return SType.make(STNative(Ref.wrap((this:NativeType))));
  }
}
// abstract class NativeTypeBase extends NativeTypeCls{

// }
@:using(stx.schema.type.NativeType.NativeTypeLift)
@:forward abstract NativeType(NativeTypeApi) from NativeTypeApi to NativeTypeApi{
  static public var _(default,never) = NativeTypeLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:NativeTypeApi):NativeType return new NativeType(self);

  @:noUsing static public function make(ident,ctype,?validation,?meta){
    return lift(new NativeTypeCls(ident,ctype,validation,meta));
  }
  public function prj():NativeTypeApi return this;
  private var self(get,never):NativeType;
  private function get_self():NativeType return lift(this);

  public function copy(?ident,?ctype,?validation,?meta){
    return make(
      
      __.option(ident).defv(this.ident),
      __.option(ctype).defv(this.ctype),
      __.option(validation).defv(this.validation),
      __.option(meta).defv(this.meta)
    );
  }
}
class NativeTypeLift{
  
}