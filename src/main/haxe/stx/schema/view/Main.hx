package stx.schema.view;


class Main{
  static public function apply(state:GTypeContext){
    final register = @:privateAccess state.context.register;
    for(type in register){
      type.leaf(state);
    }
  }
  static function toSType()Definition(self:stx.schema.Type,state:GTypeContext){
    switch(self.data){
      case TData(t)     : __.accept(None);
      case TAnon(t)     : __.accept(None);
      case TRecord(t)   : 
      case TGeneric(t)  : 
        final type = t.pop();
        switch(type.ident().toIdentifier().toString()){
          case 'std.Array' : 
        }
      case TUnion(t)    : 
      case TLink(t)     : 
      case TEnum(t)     : 
      case TLazy(f)     : 
      case TMono        :
    }
  }
}