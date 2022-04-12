package stx.schema.view;

import haxe.macro.Expr;
import haxe.macro.Type;

import stx.makro.Expr;

class Leaf{
  static public function define(self:stx.schema.Type,state:GTypeContext):Res<TypeDefinition,SchemaFailure>{
    switch(self.data){
      case TData(t)     : __.reject(__.fault().of(E_Schema_AttemptingToDefineUnsupportedType(self)));
      case TAnon(t)     : __.reject(__.fault().of(E_Schema_AttemptingToDefineUnsupportedType(self)));
      case TRecord(t)   : 
        final type    = t.pop();
        final fields  = ((type.fields).pop()).lfold(
          (next:stx.schema.core.type.Field,memo:Res<Cluster<KV<String,GTypePath>>,SchemaFailure>) -> memo.fold(
            (ok:Cluster<KV<String,GTypePath>>) -> 
              GTypeContext._.toTypePath(next.type,state)
                   .map((v:GTypePath) -> KV.make(next.name,v))
                   .map(ok.snoc),
              e  -> GTypeContext._.toTypePath(next.type,state).fold(
                _   -> memo,
                eI  -> __.reject(e.concat(eI)) 
              )
          ),
          __.accept(Cluster.unit())
        ).map(
          arr -> arr.map(
            kv -> __.g().field().Make(kv.key,ftype -> ftype.Var(kv.val.toComplexType()),acc -> [acc.Public(),acc.Final()])
          )
        );
        // final tdef  = fields.map(
        //   (fields:Cluster<GField>) -> __.g().type().Make(
        //       type.ident().name,
        //       type.ident().pack,
        //       fields
        //     )
        // );
        
        //$type(fields);
      case TGeneric(t)  : 
        final type = t.pop();
      case TUnion(t)    : 

      case TLink(t)     : 
      case TEnum(t)     : 
      case TLazy(f)     : 
      case TMono        :
    }
    return throw UNIMPLEMENTED;
  }
}