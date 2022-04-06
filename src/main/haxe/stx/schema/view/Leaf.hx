package stx.schema.view;

import haxe.macro.Expr;
import haxe.macro.Type;

import stx.makro.Expr;

class Leaf{
  static public function define(self:stx.schema.Type,state:MacroContext):Res<TypeDefinition,SchemaFailure>{
    switch(self.data){
      case TData(t)     : __.reject(__.fault().of(E_Schema_AttemptingToDefineUnsupportedType(self)));
      case TAnon(t)     : __.reject(__.fault().of(E_Schema_AttemptingToDefineUnsupportedType(self)));
      case TRecord(t)   : 
        final type    = t.pop();
        final fields  = ((type.fields).pop()).lfold(
          (next:stx.schema.core.type.Field,memo:Res<Cluster<KV<String,haxe.macro.Expr.TypePath>>,SchemaFailure>) -> memo.fold(
            (ok:Cluster<KV<String,haxe.macro.Expr.TypePath>>) -> 
              MacroContext._.toHaxeTypePath(next.type,state)
                   .map((v:haxe.macro.Expr.TypePath) -> KV.make(next.name,v))
                   .map(ok.snoc),
              e  -> MacroContext._.toHaxeTypePath(next.type,state).fold(
                _   -> memo,
                eI  -> __.reject(e.concat(eI)) 
              )
          ),
          __.accept(Cluster.unit())
        ).map(
          arr -> arr.map(
            kv -> HField.fromMember(Member.prop(kv.key,TPath(kv.val),state.pos)) 
          )
        );
        final tdef  = fields.map(
          (fields:Cluster<HField>) -> HTypeDefinition.make(
              type.ident(),
              fields
            )
        );
        
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