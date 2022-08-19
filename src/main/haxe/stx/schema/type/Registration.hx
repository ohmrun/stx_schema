package stx.schema.type;

class Registration extends Clazz{
  public function request(identity:Identity,state:State):Pledge<Option<SType>,SchemaFailure>{
    return Pledge.lift(state.obtain(identity,state.threshold).flatMap(
      x -> x.fold(
        ok -> switch((__.tracer()(ok))){
          case BOT      : Pledge.pure(None);
          case HAS(h,_) : Pledge.pure(Some(h));
          case TOP      : Pledge.make(__.reject(__.fault().of(E_Schema_Top)));
        },
        () -> {
          return Pledge.pure(None);
        }
      )
    ));
  }
  public function enquire(identity:Identity,state:State):Pledge<SType,SchemaFailure>{
    return request(identity,state).flat_map(
      opt -> opt.fold(
        ok -> Pledge.pure(ok),
        () -> register_identity(identity,state)
      )
    );
  }
  public function register_identity(data:Identity,state:State){
    return state.schema(data).fold(
      ok -> register_schema(ok,state),
      () -> Pledge.make(__.reject(__.fault().of(E_Schema_SchemaNotFound(data))))
    );
  }
  public function register_schema(data:Schema,state:State):Pledge<SType,SchemaFailure>{
    trace(data);
    return request(data.identity,state).flat_map(
      opt -> __.tracer()(opt).fold(
        ok -> Pledge.pure(ok),
        () -> {
          return switch(data){
            case SchLazy(fn)      : register_schema(fn(),state);
            case SchScalar(def)   : register_scalar(def,state);
            case SchAnon(def)     : register_anon(def,state);
            case SchRecord(def)   : register_record(def,state);
            case SchEnum(def)     : register_enum(def,state);
            case SchGeneric(def)  : register_generic(def,state);
            case SchUnion(def)    : register_union(def,state);
          }
        }
      )
    );
  }
  public function register_scalar(data:DeclareScalarSchema,state:State):Pledge<SType,SchemaFailure>{
    final register = state.context.create(); 
    final type     = ScalarType.make(register,data.ident,data.ctype,data.validation,data.meta).toSType();
    state.put(type);
    return Pledge.pure(type);
  }
  public function register_anon(data:DeclareAnonSchema,state:State):Pledge<SType,SchemaFailure>{
    final register = state.context.create(); 
    final fields   = get_fields(data.fields,state);
    final next = fields.map(
      fields -> AnonType.make(
        register,fields,data.validation,data.meta
      ).toSType()
    );
    final update = next.map(
      x -> {
        state.put(x);
        return x;
      }
    );
    return update;
  }
  public function get_fields(self:Procurements,state:State){
    return Pledge.bind_fold(
      self.prj().toCluster(),
      (n:Procure,memo:Cluster<Field>) -> {
        return (switch(n){
          case Property(def)  : 
            enquire(def.type.identity,state).map(
             (x:SType) -> Field.make(def.name,x)
            );
          case Attribute(def) : 
            final type = enquire(def.type.identity,state);
            final next = type.map(
              (stype:SType) -> {
                final registerI = state.context.create();
                final ltype     = LinkType.make(registerI,stype,def.relation,def.inverse).toSType();
                state.put(ltype);
                return ltype;
              }
            ).map(
              (x:SType) -> Field.make(def.name,x)
            );
            next;
        }).map(memo.snoc);
      },
      []
    );
  }
  public function register_record(data:DeclareRecordSchema,state:State):Pledge<SType,SchemaFailure>{
    final register            = state.context.create(); 
    final fields              = get_fields(data.fields,state);
    var next : RecordType     = null;
    var type        = Ref.make(
      data.identity,
      () -> next
    );
    state.put(STRecord(type));
    
    final result = fields.map(
      fields -> RecordType.make(
        register,data.ident,fields,data.validation,data.meta
      )
    );
    final update = result.map(
      x -> {
        next = x;
        return x.toSType();
      }
    );
    return update;
  }
  public function register_enum(data:DeclareEnumSchema,state:State):Pledge<SType,SchemaFailure>{
    final register = state.context.create(); 
    final type     = EnumType.make(register,data.ident,data.constructors,data.validation,data.meta).toSType();
    state.put(type);
    return Pledge.pure(type);
  }
  public function register_generic(data:DeclareGenericSchema,state:State):Pledge<SType,SchemaFailure>{
    final register  = state.context.create(); 
    final type      = enquire(data.type.identity,state).map(
      x -> {
        final next = GenericType.make(register,data.ident,x,data.validation,data.meta).toSType();
        state.put(next);
        return next;
      }
    );
    return type;
  }
  public function register_union(data:DeclareUnionSchema,state:State):Pledge<SType,SchemaFailure>{
    final register = state.context.create();
    final type     = Pledge.bind_fold(
      data.rest,
      (n:SchemaRef,m:Cluster<SType>) -> {
        return enquire(n.identity,state).map(m.snoc);
      },
      []
    ).map(
      (x) -> {
        final next = UnionType.make(register,data.ident,x,data.validation,data.meta).toSType();
        state.put(next);
        return next;
      }
    );
    return type;
  }
}
