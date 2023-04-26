package stx.schema.declare;

class IdentLift{
  static public function denote(self:Ident){
    final e = __.glot().expr();
    return e.Call(
      e.Path('stx.nano.Ident.make'),
      [
        e.Const( c -> c.String(self.name)),
        e.Call(
          e.Path('stx.nano.Way.make'),
          [
            e.ArrayDecl(
              __.option(self.pack).defv([]).prj().map(
                str -> e.Const(
                  c -> c.String(str)
                )
              )
            )
          ]
        )
      ]
    );
  }
}