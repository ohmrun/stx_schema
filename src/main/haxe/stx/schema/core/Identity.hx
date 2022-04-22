package stx.schema.core;

typedef IdentityDef = IdentDef & {
  final lhs   : Option<Identity>;
  final rhs   : Option<Identity>;
}
@:using(stx.schema.core.Identity.IdentityLift)
@:forward abstract Identity(IdentityDef) from IdentityDef to IdentityDef{
  static public var _(default,never) = IdentityLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:IdentityDef):Identity return new Identity(self);

  public function prj():IdentityDef return this;
  private var self(get,never):Identity;
  private function get_self():Identity return lift(this);

  @:noUsing static public function make(ident:Ident,lhs:Option<Identity>,rhs:Option<Identity>){
    return lift({
      name : ident.name,
      pack : ident.pack,
      lhs  : lhs,
      rhs  : rhs
    });
  }
  // public function down(name:String,pack:Array<String>){
  //   return Identity.make(
  //     Ident.make(
  //       name,
  //       this.pack.concat([(this.name:Chars).uncapitalize_first_letter()].concat(pack))
  //     ),
  //     this.lhs,
  //     this.rhs
  //   );
  // }
  public function toString():String{
    final code = (this:Ident).toIdentifier();
    final rest =  switch([this.lhs,this.rhs]){
      case [Some(l),Some(r)]  : '(${l.toString()},${r.toString()})';
      case [Some(l),None]     : '(${l.toString()},_)';
      case [None,Some(r)]     : '(_,${r.toString()})';
      case [None,None]        : '(_,_)';
    }
    return '$code$rest';
  }
  @:from static public function fromIdent(self:Ident){
    return make(self,None,None);
  }
  public function toIdent_munged():Ident{
    return switch([this.lhs,this.rhs]){
      case [Some(l),Some(r)] : 
        final ls = l.toIdent_munged().toString_underscored();
        final rs = r.toIdent_munged().toString_underscored();
        Ident.make('${this.name}WithBoth${ls}And${rs}',this.pack);
      case [Some(t),None]    :
        Ident.make('${this.name}With${t}',this.pack);
      case [None,Some(t)]    :
        Ident.make('${this.name}With${t}',this.pack);
      case [None,None]  : 
        Ident.make(this.name,this.pack);
    }
  }
}
class IdentityLift{
  static public function to_self_constructor(self:Identity):GExpr{
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
        self.lhs.map(to_self_constructor).def(() -> e.Path('stx.pico.Option.None')),
        self.rhs.map(to_self_constructor).def(() -> e.Path('stx.pico.Option.None'))
      ]
    );
  }
}