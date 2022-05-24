package stx.schema;

using stx.Parse;

function id(str){
  return __.parse().id(str);
}
class Munge{
  static final fld : String = "___FLD___";
  static final pkg : String = "___PKG___";
  static final nme : String = "___NME___";
  static final sep : String = "___SEP___";
  static final lbr : String = "___LBR___";
  static final rbr : String = "___RBR___";
  static final pre : String = "___STX___";
  static final typ : String = "___TYP___";
  static final ano : String = "___ANO___";

  static private function inner_ident(that:Ident){
    final n = that.name;
    final p = that.pack;
    return if(that.pack == null || !that.pack.is_defined()){
      '$n';
    }else{
      final pI = p.join(sep);
      '$pkg${pI}$nme$n';
    }
  }
  static public function encode(value:Identity):String{
    return toIdent(value).toIdentifier().toString();
  }
  static public function toIdent(value:Identity):Ident{
    function inner(that:Identity){
      final me = inner_ident({name : that.name,pack : that.pack});  
      return that.rest.is_defined().if_else(
        () -> {
          final re = __.option(that.rest).defv([]).map(
            v -> inner(v)
          ).join(sep);
          return '$me$lbr$re$rbr';
        },
        () -> {
          return '$me';
        }
      );
    }
    final rest = __.option(value.rest).defv([]);
    return rest.is_defined().if_else(
      () -> {
        final re = rest.map(
          v -> inner(v)
        ).join(sep);
        return Ident.make('${value.name}$lbr$re$rbr',value.pack);
      },
      () -> {
        return ({name : value.name,pack : value.pack}:Ident);
      }
    );
  }
  static final p_fld = id(fld);
  static final p_pkg = id(pkg);
  static final p_nme = id(nme);
  static final p_sep = id(sep);
  static final p_lbr = id(lbr);
  static final p_rbr = id(rbr);
  static final p_pre = id(pre);
  static final p_typ = id(typ);
  static final p_ano = id(ano);
  
  // static public function decode(value:String):Res<Identity,SchemaFailure>{
  //   final input = value.reader();   
  //   return p_ident().and(
      
  //   );
  // }
  // static public function p_scope(){
  //   return p_lbr.and(
  //     p_pkg()._and(
  //       p_pack().repsep(p_sep)
  //     ).and(
  //       p_nme._and(p_name())
  //     ).and(

  //     )    
  //   )
  // }
  static public function p_ident(){
    return p_name().then(x -> Ident.make(x)).or(
      p_pack().repsep(id(".")).and(p_name()).then(
        __.decouple(
          (x,y) -> Ident.make(y,x)
        )
      )
    );
  }
  static public function p_name(){
    return Parse.upper.or(id("_")).and(
      Parse.alpha.many()
    ).then(
      __.decouple(
        (l:String,r:Cluster<String>) -> '${l}${r.join("")}'
      )
    );
  }
  static public function p_pack(){
    return Parse.lower.one_many().tokenize();
  }
}