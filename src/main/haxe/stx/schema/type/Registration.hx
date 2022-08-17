package stx.schema.type;

class Registration{
  // public function register_schema(data:Schema,state:State):Pledge<SType,SchemaFailure>{
  //   return state.obtain(
  //     data.identity,
  //     state.threshold
  //   ).flatMap(
  //     opt -> opt.fold(
  //       (ok) -> ok,
  //       ()   -> {
  //         return switch(data){
  //           case SchLazy(fn)      : register_schema(fn(),state);
  //           case SchScalar(def)   : register_scalar(def,state);
  //           case SchAnon(def)     : register_anon(def,state);
  //           case SchRecord(def)   : null;
  //           case SchEnum(def)     : null;
  //           case SchGeneric(def)  : null;
  //           case SchUnion(def)    : null;
  //         }
  //       }
  //     )
  //   );
  // }
  // //(register,ident,ctype,?validation,?meta)
  // public function register_scalar(data:DeclareScalarSchema,state:State):Pledge<SType,SchemaFailure>{
  //   final register = state.context.create(); 
  //   final type     = ScalarType.make(register,data.ident,data.ctype,data.meta,data.validation).toSType();
  //   state.put(type);
  //   return Pledge.pure(type);
  // }
  // public function register_anon(data:DeclareAnonSchema,state:State):Pledge<SType,SchemaFailure>{
  //   final register = state.context.create(); 
  //   final fields   = Pledge.bind_fold(
  //     data.fields.prj(),
  //     (n:Procure,memo:Cluster<Field>) -> {
  //       return switch(n){
  //         case Property(def)  : 
  //           state.obtain(def.type.identity,state.threshold).flat_map(
  //             x -> x.fold(
  //               ok -> switch(ok){
  //                 case BOT : state.schema(def.type.identity).fold(
  //                   ok -> register_schema(ok),
  //                   () -> Pledge.Sync(__.reject(__.fault().of(E_Schema_SchemaNotFound(def.type.identity))))
  //                 );
  //                 case HAS(h) : Pledge.pure(h);
  //               }
  //             )
  //           ).map(
  //             (x:SType) -> Field.make(def.name,x)
  //           ).map(memo.snoc);
  //         case Attribute(def) : null;
  //       }
  //     } 
  //   );
  //   //final type     = Anon.make(register,data.ident,data.ctype,data.meta,data.validation).toSType();
  //   //state.put(type);
  //   return Pledge.pure(type);
  // }
}