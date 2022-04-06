package stx.schema;

typedef TypeStatus                  = stx.schema.core.type.TypeStatus;

typedef BaseTypeApi                 = stx.schema.core.type.BaseType.BaseTypeApi;
typedef BaseTypeCls                 = stx.schema.core.type.BaseType.BaseTypeCls;


typedef FieldDef                    = stx.schema.core.type.Field.FieldDef;
typedef Field                       = stx.schema.core.type.Field;

typedef TypeSum                     = stx.schema.core.Type.TypeSum;
typedef Type                        = stx.schema.core.Type;

typedef DataTypeApi                 = stx.schema.core.type.DataType.DataTypeApi;
typedef DataTypeCls                 = stx.schema.core.type.DataType.DataTypeCls;
typedef DataType                    = stx.schema.core.type.DataType;

typedef AnonTypeApi                 = stx.schema.core.type.AnonType.AnonTypeApi;
typedef AnonTypeCls                 = stx.schema.core.type.AnonType.AnonTypeCls;
typedef AnonType                    = stx.schema.core.type.AnonType;

typedef RecordTypeApi               = stx.schema.core.type.RecordType.RecordTypeApi;
typedef RecordTypeCls               = stx.schema.core.type.RecordType.RecordTypeCls;
typedef RecordType                  = stx.schema.core.type.RecordType;

typedef GenericTypeApi              = stx.schema.core.type.GenericType.GenericTypeApi;
typedef GenericTypeCls              = stx.schema.core.type.GenericType.GenericTypeCls;
typedef GenericType                 = stx.schema.core.type.GenericType;

typedef UnionTypeCls                = stx.schema.core.type.UnionType.UnionTypeCls;
typedef UnionTypeApi                = stx.schema.core.type.UnionType.UnionTypeApi;
typedef UnionType                   = stx.schema.core.type.UnionType;


typedef LinkTypeCls                 = stx.schema.core.type.LinkType.LinkTypeCls;
typedef LinkTypeApi                 = stx.schema.core.type.LinkType.LinkTypeApi;
typedef LinkType                    = stx.schema.core.type.LinkType;

typedef EnumTypeApi                 = stx.schema.core.type.EnumType.EnumTypeApi;
typedef EnumTypeCls                 = stx.schema.core.type.EnumType.EnumTypeCls;
typedef EnumType                    = stx.schema.core.type.EnumType;

typedef Has_toStringDef             = stx.schema.core.type.Has_toStringDef;
typedef Has_toStringApi             = stx.schema.core.type.Has_toString.Has_toStringApi;
typedef Has_toStringCls             = stx.schema.core.type.Has_toString.Has_toStringCls;

typedef Ref<T:Has_toStringDef>      = stx.schema.core.Ref<T>;
typedef RefDef<T:Has_toStringDef>   = stx.schema.core.Ref.RefDef<T>;

typedef WithValidationCls           = stx.schema.core.WithValidation.WithValidationCls;
typedef WithValidationApi           = stx.schema.core.WithValidation.WithValidationApi;

typedef Identity                    = stx.schema.core.Identity;
typedef Context                     = stx.schema.core.Context;
typedef LeafType                    = stx.schema.core.type.LeafType;
typedef LazyType                    = stx.schema.core.type.LazyType;

// typedef LinkTypeDef                 = stx.schema.core.type.LinkType.LinkTypeDef;
// typedef LinkType                    = stx.schema.core.type.LinkType

// typedef SchemaBool                  = stx.schema.core.type.term.SchemaBool;
// typedef SchemaInt                   = stx.schema.core.type.term.SchemaInt;
// typedef SchemaString                = stx.schema.core.type.term.SchemaString;
// typedef SchemaNull                  = stx.schema.core.type.term.SchemaNull;

class LiftSchema_register{
  static public function register(self:Schema,state:Context){
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
        def.register(state);
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
class LiftSchemaDeclaration{
  static public function register(self:SchemaDeclaration,state:Context){
    return state.get(self.identity()).fold(
      ok -> ok,
      () -> {
        final type = TData(Ref.pure((LeafType.make(self.id.name,self.id.pack,self.validation):DataType)));
        state.put(type);
        return type;
      }
    );
  }
}
class LiftSchemaUnionDeclaration{
  static public function register(self:SchemaUnionDeclaration,state:Context):Type{
    final lhs   = self.lhs.register(state);
    final rhs   = self.rhs.register(state);
    final type  = UnionType.make(self.id.name,self.id.pack,lhs,rhs,self.validation).toType();
    state.put(type);
    return type;
  }
}
class LiftSchemaEnumDeclaration_register{
  static public function register(self:SchemaEnumDeclaration,state:Context):Type{
    final type = EnumType.make(self.id.name,self.id.pack,self.constructors).toType();
    state.put(type);
    return type;
  }
}
class LiftSchemaGenericDeclaration_register{
  static public function register(self:SchemaGenericDeclaration,state:Context):Type{
    var next : GenericType    = null;
    final fn = function(){
      __.log().debug(self.identity().toString());
      return __.option(next).def(() ->throw E_Schema_IdentityUnresolved(self.identity()));
    }
    var type                  = TGeneric(Ref.make(fn));
    state.put(type);

    next = state.get(self.type.identity()).fold(
      (ok:Type) -> {
        final next = GenericType.make(self.id.name,self.id.pack,ok,self.validation);
        return next;
      },
      () -> {
        return __.option(self.type.pop).fold(
          ok -> {
            final subtype = ok().register(state);
            final next    = GenericType.make(self.id.name,self.id.pack,subtype,self.validation);
            return next;
          },
          () -> {
            __.log().trace("HERERERER");
            return GenericType.make(self.id.name,self.id.pack,TMono,self.validation);
          }
        );
      }
    );
    state.put(type);
    return type;
  }
}
class LiftSchemaRecordDeclaration_register{
  static public function register(self:SchemaRecordDeclaration,state:Context):Type{
    var next : RecordType     = null;
    var fn                    = function(){
      //__.log().debug(self.identity().toString());
      return __.option(next).def(() ->throw E_Schema_IdentityUnresolved(self.identity()));
    }
    var type                  = TRecord(Ref.make(fn));

    final fs = self.fields.lfold(
      function (next:Procurement,memo:Cluster<stx.schema.core.type.Field>):Cluster<stx.schema.core.type.Field> {
        final id    = next.type.identity();
        __.log().debug('$id');
        final type : Type = switch(next){
          case Property(prop)   : 
            next.type.register(state);
          case Attribute(attr)  : 
            //__.tracer()(next.type.register(state));
            final type = state.get(attr.type.identity()).def(() -> attr.type.register(state));
            final link = LinkType.make(type,attr.relation,attr.inverse,attr.validation);
            link.toType().register(state);
        }
        __.log().debug(_ -> _.pure(type));
        return memo.snoc(stx.schema.core.type.Field.make(next.name,type));
      },
      Cluster.unit()
    );
    
    next = new RecordTypeCls(self.id.name,self.id.pack,fs);
    state.put(type);
    return type;
  }
}
