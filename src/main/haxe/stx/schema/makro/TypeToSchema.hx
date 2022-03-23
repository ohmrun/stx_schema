package stx.schema.makro;

import haxe.macro.Type;

using stx.makro.Type;

class TypeToSchema{
  static public function main(){

  }
  // static public function toSchema(type:haxe.macro.Type){
  //   function f(type:Type){
  //     return switch(type){
  //       case TInst(t,[])        :	
  //       case TInst(t, arr)      : __.reject(__.fault().of(E_Schema_UnexpectedGeneric));
  //       case TAbstract(t, [])   :
  //       case TAbstract(t, arr)  : __.reject(__.fault().of(E_Schema_UnexpectedGeneric));
  //       case TEnum(t, []):
  //       case TEnum(t, arr)      : __.reject(__.fault().of(E_Schema_UnexpectedGeneric));
  //       case TFun(args, ret)    : __.accept(None);
  //       case TAnonymous(t)      : 
  //         final tI      = t.get();
  //         final fields  = tI.get_fields(); 
  //       case TDynamic(null)     :  __.reject(__.fault().of(E_Schema_UnexpectedType));
  //       case TDynamic(v)        :
  //       case TLazy(fn)          :
  //       case TMono(t):
  //       case TType(t, []):
  //       case TType(t, arr):
  //     } 
  //   }
  //   return throw UNIMPLEMENTED;
  // } 
}