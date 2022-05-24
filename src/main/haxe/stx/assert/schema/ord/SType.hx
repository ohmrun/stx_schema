package stx.assert.schema.ord;

import stx.schema.SType as TSType;

abstract class SType extends OrdCls<TSType>{
  
  // public function lt(thiz:TSType,that:TSType){
  //   return switch([thiz,that]){
  //       case [STScalar(l),STScalar(r)]      : 
  //       case [STAnon(l),STAnon(r)]          :
  //       case [STRecord(l),STRecord(r)]      :
  //       case [STGeneric(l),STGeneric(r)]    :
  //       case [STUnion(l),STUnion(r)]        :  STypeSType
  //       case [STLink(l),STLink(r)]          :
  //       case [STEnum(l),STEnum(r)]          :
  //       case [STLazy(l),STLazy(r)]          :
  //       case [STMono,STMono]                : NotLessThan;
  //   }
  // }
}