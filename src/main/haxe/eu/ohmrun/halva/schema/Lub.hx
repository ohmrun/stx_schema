package eu.ohmrun.halva.schema;

class Lub extends SemiGroupCls<LVar<SType>>{
  final comparable : Comparable<SType>;
  public function new(){
    super();
    this.comparable = new stx.assert.schema.type.comparable.SType();
  }
  public function plus(lhs:LVar<SType>,rhs:LVar<SType>){
    final result = switch([lhs.prj(),rhs.prj()]){
      case [HAS(_,true),HAS(_,_)]                                     : TOP;
      case [TOP, _ ]                                                  : TOP;
      case [_, TOP]                                                   : TOP;
      case [HAS(l,_),HAS(r,b)]                                        :
        final lI = l;
        final rI = r;
        switch([lI,rI]){
          case [_.get_data() => STMono ,t]                               : HAS(t,b);
          case [_.get_data() => STLazy(_) ,tII]                          : HAS(tII,b);
          case [_.get_enum_value_index() => iI,_.get_enum_value_index() => iII] if (iI == iII) :
            this.comparable.is_greater_or_equal(l,r).if_else(
              () -> HAS(l,b),
              () -> HAS(r,b)
            );
          default                                                     : TOP;
        }
      case [BOT,BOT]  : BOT;
      case [BOT,x]    : x;
      case [_,BOT]    : TOP;
    }
    return result;
  }
}
