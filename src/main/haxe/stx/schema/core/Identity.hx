package stx.schema.core;

typedef IdentityDef = IdentDef & {
  final ?rest  : Cluster<Identity>;
}
@:using(stx.schema.core.Identity.IdentityLift)
@:forward abstract Identity(IdentityDef) from IdentityDef to IdentityDef{
  static public var _(default,never) = IdentityLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:IdentityDef):Identity return new Identity(self);

  static public function identity(wildcard:Wildcard,name:String,?pack:Way,?rest:Cluster<Identity>){
    return Identity.make(
      Ident.make(
        name,
        __.option(pack).defv(Way.unit())
      ),
      __.option(rest).def(Cluster.unit)
    );
  }
  static public function toIdentity(self:Ident){
    return Identity.make(self,[]);
  }
  public function prj():IdentityDef return this;
  private var self(get,never):Identity;
  private function get_self():Identity return lift(this);

  @:noUsing static public function make(ident:Ident,rest:Cluster<Identity>){
    return lift({
      name : ident.name,
      pack : ident.pack,
      rest : rest
    });
  }
  public function toString():String{
    final code = (this:Ident).toIdentifier();
    final rest =  this.rest.map(x -> x.toString()).join(",");
    return '$code($rest)';
  }
  @:from static public function fromIdent(self:Ident){
    return make(self,[]);
  }
  public function toIdent_munged():Ident{
    return Munge.toIdent(this);
  }
  public function canonical(){
    return toString();
  }
  public function mod(f:Ident -> Ident):Identity{
    return make(f(Ident.make(this.name,this.pack)),this.rest);
  }
  public function equals(that:Identity){
    return new stx.assert.schema.core.eq.Identity().comply(this,that).is_equal();
  }
}
class IdentityLift{
  static public function denote(self:Identity):GExpr{
    // final e = __.glot().expr();
    // return e.Call(
    //   e.Path('stx.schema.core.Identity.make'),
    //   [
    //     e.Call(
    //       e.Path('stx.schema.core.Ident.make'),
    //       [
    //         e.Const(c -> c.String(self.name) ),
    //         e.ArrayDecl(
    //           __.option(self.pack).defv([]).prj().map(
    //             string -> e.Const(c -> c.String(string))
    //           )
    //         )
    //       ]
    //     ),
    //     e.ArrayDecl(__.option(self.rest).defv([]).map(denote))
    //   ]
    // );
    return throw UNIMPLEMENTED;
  }
}