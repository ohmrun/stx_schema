package stx;

class SchemaModuleCtr{
  static public function schema(wildcard:Wildcard){
    return new stx.schema.Module();
  } 
}
typedef SchemaFailure                             = stx.fail.SchemaFailure;
typedef SchemaFailureSum                          = stx.fail.SchemaFailure.SchemaFailureSum;

typedef DeclareSchema                             = stx.schema.declare.DeclareSchema;
typedef DeclareSchemaApi                          = stx.schema.declare.DeclareSchema.DeclareSchemaApi;
typedef DeclareSchemaCls                          = stx.schema.declare.DeclareSchema.DeclareSchemaCls;
typedef DeclareSchemaBase                         = stx.schema.declare.DeclareSchema.DeclareSchemaBase;
typedef DeclareSchemaConcrete                     = stx.schema.declare.DeclareSchema.DeclareSchemaConcrete;

typedef DeclareScalarSchema                       = stx.schema.declare.DeclareScalarSchema;
typedef DeclareScalarSchemaApi                    = stx.schema.declare.DeclareScalarSchema.DeclareScalarSchemaApi;
typedef DeclareScalarSchemaCls                    = stx.schema.declare.DeclareScalarSchema.DeclareScalarSchemaCls;

typedef DeclareRecordSchema                       = stx.schema.declare.DeclareRecordSchema;
typedef DeclareRecordSchemaCls                    = stx.schema.declare.DeclareRecordSchema.DeclareRecordSchemaCls;
typedef DeclareRecordSchemaApi                    = stx.schema.declare.DeclareRecordSchema.DeclareRecordSchemaApi;

typedef DeclareGenericSchema                      = stx.schema.declare.DeclareGenericSchema;
typedef DeclareGenericSchemaApi                   = stx.schema.declare.DeclareGenericSchema.DeclareGenericSchemaApi;
typedef DeclareGenericSchemaCls                   = stx.schema.declare.DeclareGenericSchema.DeclareGenericSchemaCls;

typedef DeclareUnionSchema                        = stx.schema.declare.DeclareUnionSchema;
typedef DeclareUnionSchemaApi                     = stx.schema.declare.DeclareUnionSchema.DeclareUnionSchemaApi;
typedef DeclareUnionSchemaCls                     = stx.schema.declare.DeclareUnionSchema.DeclareUnionSchemaCls;

typedef DeclareEnumSchema                         = stx.schema.declare.DeclareEnumSchema;
typedef DeclareEnumSchemaApi                      = stx.schema.declare.DeclareEnumSchema.DeclareEnumSchemaApi;
typedef DeclareEnumSchemaCls                      = stx.schema.declare.DeclareEnumSchema.DeclareEnumSchemaCls;

typedef Procure                                   = stx.schema.declare.Procure;
typedef ProcureSum                                = stx.schema.declare.Procure.ProcureSum;

typedef Procurements                              = stx.schema.declare.Procurements;
typedef ProcurementsDef                           = stx.schema.declare.Procurements.ProcurementsDef;

typedef DeclareProperty                           = stx.schema.declare.DeclareProperty;
typedef DeclarePropertyDef                        = stx.schema.declare.DeclareProperty.DeclarePropertyDef;

typedef DeclareAttribute                          = stx.schema.declare.DeclareAttribute;
typedef DeclareAttributeDef                       = stx.schema.declare.DeclareAttribute.DeclareAttributeDef;

typedef ProcureAttributeDef                       = stx.schema.declare.ProcureAttribute.ProcureAttributeDef;
typedef ProcureAttribute                          = stx.schema.declare.ProcureAttribute; 

typedef ProcurePropertyDef                        = stx.schema.declare.ProcureProperty.ProcurePropertyDef;
typedef ProcureProperty                           = stx.schema.declare.ProcureProperty; 


// typedef SchemaAnonDeclaration                     = stx.schema.SchemaAnonDeclaration;
// typedef SchemaAnonDeclarationDef                  = stx.schema.SchemaAnonDeclaration.SchemaAnonDeclarationDef;

typedef Schema                                    = stx.schema.Schema;
typedef SchemaSum                                 = stx.schema.Schema.SchemaSum;

typedef RelationType                              = stx.schema.RelationType;

typedef SchemaRef                                 = stx.schema.SchemaRef;
typedef SchemaRefDef                              = stx.schema.SchemaRef.SchemaRefDef;

typedef ValidationSum                             = stx.schema.Validation.ValidationSum;
typedef Validation                                = stx.schema.Validation;
typedef Validations                               = stx.schema.Validations;
typedef WithValidationDef                         = stx.schema.WithValidationDef;

typedef TyperContext                              = stx.schema.TyperContext;
typedef TyperContextCls                           = stx.schema.TyperContext.TyperContextCls;
typedef ValidationComplyApi                       = ComplyApi<Dynamic,stx.schema.SType,Report<SchemaFailure>>;
typedef ValidationComplyCls                       = ComplyCls<Dynamic,stx.schema.SType,Report<SchemaFailure>>;

typedef TypeStatus                                = stx.schema.type.TypeStatus;

typedef BaseTypeApi                               = stx.schema.type.BaseType.BaseTypeApi;
typedef BaseTypeCls                               = stx.schema.type.BaseType.BaseTypeCls;
//typedef BaseType                                  = stx.schema.type.BaseType.BaseType;

typedef STypeSum                                  = stx.schema.SType.STypeSum;
typedef SType                                     = stx.schema.SType;

typedef DataTypeApi                               = stx.schema.type.DataType.DataTypeApi;
typedef DataTypeCls                               = stx.schema.type.DataType.DataTypeCls;
typedef DataType                                  = stx.schema.type.DataType;

typedef ScalarTypeApi                             = stx.schema.type.ScalarType.ScalarTypeApi;
typedef ScalarTypeCls                             = stx.schema.type.ScalarType.ScalarTypeCls;
typedef ScalarType                                = stx.schema.type.ScalarType;


typedef AnonTypeApi                               = stx.schema.type.AnonType.AnonTypeApi;
typedef AnonTypeCls                               = stx.schema.type.AnonType.AnonTypeCls;
typedef AnonType                                  = stx.schema.type.AnonType;

typedef RecordTypeApi                             = stx.schema.type.RecordType.RecordTypeApi;
typedef RecordTypeCls                             = stx.schema.type.RecordType.RecordTypeCls;
typedef RecordType                                = stx.schema.type.RecordType;

typedef GenericTypeApi                            = stx.schema.type.GenericType.GenericTypeApi;
typedef GenericTypeCls                            = stx.schema.type.GenericType.GenericTypeCls;
typedef GenericType                               = stx.schema.type.GenericType;

typedef UnionTypeCls                              = stx.schema.type.UnionType.UnionTypeCls;
typedef UnionTypeApi                              = stx.schema.type.UnionType.UnionTypeApi;
typedef UnionType                                 = stx.schema.type.UnionType;


typedef LinkTypeCls                               = stx.schema.type.LinkType.LinkTypeCls;
typedef LinkTypeApi                               = stx.schema.type.LinkType.LinkTypeApi;
typedef LinkType                                  = stx.schema.type.LinkType;

typedef EnumTypeApi                               = stx.schema.type.EnumType.EnumTypeApi;
typedef EnumTypeCls                               = stx.schema.type.EnumType.EnumTypeCls;
typedef EnumType                                  = stx.schema.type.EnumType;

typedef Has_getIdentityDef                        = stx.schema.type.Has_getIdentityDef;
typedef Has_getIdentityApi                        = stx.schema.type.Has_getIdentity.Has_getIdentityApi;
typedef Has_getIdentityCls                        = stx.schema.type.Has_getIdentity.Has_getIdentityCls;
typedef WithValidationCls                         = stx.schema.WithValidation.WithValidationCls;
typedef WithValidationApi                         = stx.schema.WithValidation.WithValidationApi;

typedef LeafType                                  = stx.schema.type.LeafType;
typedef LazyType                                  = stx.schema.type.LazyType;

typedef GTypeContext                              = stx.schema.GTypeContext;
typedef TypeContext                               = stx.schema.TypeContext;

// typedef LinkTypeDef                            = stx.schema.type.LinkType.LinkTypeDef;
// typedef LinkType                               = stx.schema.type.LinkType

// typedef SchemaBool                             = stx.schema.type.term.SchemaBool;
// typedef SchemaInt                              = stx.schema.type.term.SchemaInt;
// typedef SchemaString                           = stx.schema.type.term.SchemaString;
// typedef SchemaNull                             = stx.schema.type.term.SchemaNull;

class LiftSchema_register{
  static public function register(self:Schema,state:TypeContext){
    return switch(self){
      case SchScalar(def)   :
        __.log().debug('register scalar'); 
        def.register(state); 
      case SchRecord(def)   : 
        __.log().debug('register record');
        def.register(state);
      case SchEnum(def)     :
        __.log().debug('register enum'); 
        def.register(state);
      case SchGeneric(def)  : 
        __.log().debug('register generic');
        LiftDeclareGenericSchema_register.register(def,state);
      case SchUnion(def)    :
        __.log().debug('register union'); 
        def.register(state);
      case SchLazy(fn)      : 
        __.log().debug('register lazy');
        final schema = fn();
        __.log().debug('unlazy');
        fn().register(state);
      case SchType(type)    : 
        __.log().debug('register type');
        type.register(state);
    }
  }
}
class LiftDeclareSchema{
  static public function register(self:DeclareScalarSchema,state:TypeContext){
    return state.get(self.id).fold(
      ok -> ok,
      () -> {
        final ident = Ident.make(self.id.name,self.id.pack);
        final ref   = () -> Identity.fromIdent(ident);
        final inner = LeafType.make(ident,self.ctype,self.meta,self.validation);
        final type  = STScalar(Ref.make(ref,() -> (inner:ScalarType)));
        state.put(type);
        return type;
      }
    );
  }
}
class LiftDeclareUnionSchema{
  static public function register(self:DeclareUnionSchema,state:TypeContext):SType{
    final rest  = self.rest.map(x -> x.register(state));
    final type  = UnionType.make(self.ident,rest,self.meta,self.validation).toSType();
    state.put(type);
    return type;
  }
}
class LiftDeclareEnumSchema_register{
  static public function register(self:DeclareEnumSchema,state:TypeContext):SType{
    final type = EnumType.make(self.ident,self.constructors,self.meta,self.validation).toSType();
    state.put(type);
    return type;
  }
}
class LiftDeclareGenericSchema_register{
  static public function register(self:DeclareGenericSchema,state:TypeContext):SType{
    var next : GenericType    = null;
    final fn = function(){
      __.log().debug(self.id.toString());
      trace(next);
      return __.option(next).def(() ->throw E_Schema_IdentityUnresolved(self.id));
    }
    var type                  = STGeneric(
      Ref.make(
        () -> Identity.make(self.ident,[Identity.lift(self.type)]),
        fn
      )
    );
    trace(self.type.id);
    try{
      state.put(type);
    }catch(e:haxe.Exception){
      trace(e);
      throw(e);
    }
    
    trace(self.type.id);

    next = state.get(self.type.id).fold(
      (ok:SType) -> {
        final next = GenericType.make(self.ident,ok,self.meta,self.validation);
        return next;
      },
      () -> {
        return __.option(self.type.pop).fold(
          ok -> {
            final subtype = ok().register(state);
            final next    = GenericType.make(self.ident,subtype,self.meta,self.validation);
            return next;
          },
          () -> {
            __.log().trace("HERERERER");
            return GenericType.make(self.ident,STMono,self.meta,self.validation);
          }
        );
      }
    );
    trace(next);
    state.put(type);
    return type;
  }
}
class LiftDeclareRecordSchema_register{
  static public function register(self:DeclareRecordSchema,state:TypeContext):SType{
    var next : RecordType     = null;
    var fn                    = function(){
      //__.log().debug(self.id.toString());
      return __.option(next).def(() ->throw E_Schema_IdentityUnresolved(self.id));
    }
    var type                  = STRecord(Ref.make(() -> Identity.fromIdent(self.ident),fn));

    final fs = self.fields.lfold(
      function (next:Procure,memo:Cluster<stx.schema.core.Field>):Cluster<stx.schema.core.Field> {
        final id    = next.type.id;
        __.log().debug('$id');
        final type : SType = switch(next){
          case Property(prop)   : 
            next.type.register(state);
          case Attribute(attr)  : 
            //__.tracer()(next.type.register(state));
            final type = state.get(attr.type.id).def(() -> attr.type.register(state));
            final link = LinkType.make(type,attr.relation,attr.inverse,PEmpty,attr.validation);
            link.toSType().register(state);
        }
        //__.log().debug(_ -> _.pure(type));
        return memo.snoc(stx.schema.core.Field.make(next.name,type));
      },
      Cluster.unit()
    );
    
    next = new RecordTypeCls(Ident.make(self.id.name,self.id.pack),fs,self.meta,self.validation);
    state.put(type);
    return type;
  }
}
class LiftGComplexTypeCtrIdentityToGComplexType{
  static public function fromIdentity(ctr:GComplexTypeCtr,self:Identity){
    final rest = __.option(self.rest).defv([]).map(fromIdentity.bind(ctr)).map(GTPType);
    return GTypePath.__.Make(self.name,self.pack,null,rest);
  }
}