package stx.schema.core;

typedef IdentityDef = IdentDef & {
  final ?rest  : Cluster<Identity>;
}
@:using(stx.schema.core.Identity.IdentityLift)
@:forward abstract Identity(IdentityDef) from IdentityDef to IdentityDef{
  static public var _(default,never) = IdentityLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:IdentityDef):Identity return new Identity(self);

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
}
class IdentityLift{
  static public function denote(self:Identity):GExpr{
    final e = __.g().expr();
    return e.Call(
      e.Path('stx.schema.core.Identity.make'),
      [
        e.Call(
          e.Path('stx.schema.core.Ident.make'),
          [
            e.Const(c -> c.String(self.name) ),
            e.ArrayDecl(
              __.option(self.pack).defv([]).prj().map(
                string -> e.Const(c -> c.String(string))
              )
            )
          ]
        ),
        e.ArrayDecl(__.option(self.rest).defv([]).map(denote))
      ]
    );
  }
}