package stx.schema.core;

typedef IdentityDef = IdentDef & {
  final lhs   : Option<Identity>;
  final rhs   : Option<Identity>;
}
@:forward abstract Identity(IdentityDef) from IdentityDef to IdentityDef{
  public function new(self) this = self;
  static public function lift(self:IdentityDef):Identity return new Identity(self);

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
}