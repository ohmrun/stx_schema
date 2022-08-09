package stx.schema.test;

using eu.ohmrun.Halva;
using eu.ohmrun.halva.Core;

class HalvaContextTest extends TestCase{
  public function types(){
    final _       = __.schema();
    final user    = _.record({
      name   : "User",
      fields : {
        properties : [
          "username" => Schema.String(),
          "age"      => Schema.Int()
        ],
        attributes : [
          "article" => {
            inverse   : "author",
            type      : __.way().into("Article"),
            relation  : HAS_MANY
          }
        ]
      }
    });
    final article   = _.record({
      name    : "Article",
      fields  : {
        "properties" : [
          "title" => Schema.String()
        ],
        "attributes" : [
          "author" => {
            inverse   : "article",
            type      : __.way().into("User"),
            relation  : HAS_MANY,
            meta      : PEmpty
          }
        ]
      }
    });
    return [user,article];
  }
  public function test(){
    // final accretion = Accretion.pure(
    //   new Lub().toSemiGroup()
    // );
    // map_put(SchScalar(stx.schema.declare.term.SchemaBool.make()));
    // map_put(SchScalar(stx.schema.declare.term.SchemaFloat.make()));
    // map_put(SchScalar(stx.schema.declare.term.SchemaInt.make()));
    // map_put(SchScalar(stx.schema.declare.term.SchemaString.make()));
        
    // for(decl in types() ){
    //   trace(decl);
    //   //accretion.put()
    // }
  }
}
private class Lub extends SemiGroupCls<LVar<SType>>{
  final comparable : Comparable<LVar<SType>>;
  public function new(){
    super();
    this.comparable = new stx.assert.halva.comparable.LVar(new stx.assert.schema.type.comparable.SType());
  }
  public function plus(lhs:LVar<SType>,rhs:LVar<SType>){
    // final result = switch([lhs.prj(),rhs.prj()]){
    //   case [HAS(_,true),HAS(_,false)]                                 : TOP;
    //   case [TOP, _ ]                                                  : TOP;
    //   case [_, { frozen : _, value : TOP}]                            : Memo.pure(TOP);
    //   case [{value : l, frozen : _}, {value : r, frozen : b}]         :
    //     var result = switch([l,r]){
    //       case [HAS({ data : STMono }),HAS({ data : t })]             : Memo.pure(HAS(SType.make(t)));
    //       case [HAS(({ data : STLazy(tI) })),HAS({ data : tII })]     : Memo.pure(HAS(SType.make(tII)));//TODO more error checking
    //       case [BOT,BOT]                                              : Memo.pure(BOT);
    //       case [BOT,HAS({ data : t })]                                : Memo.pure(HAS(SType.make(t)));
    //       default                                                     : Memo.pure(TOP);
    //     }
    //     if(b){
    //       result = result.freeze();
    //     }
    //     result;
    //   default : null;
    // }
    // return result;
    return throw UNIMPLEMENTED;
  }
}
private class Lookup{
  // static public function lookup(self:Accretion<SType>,identity:Identity):Signal<LVar<SType>>{
  //   return self.redeem()
  // }
}