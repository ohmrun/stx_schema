package stx.schema.core;

class MacroContext extends Clazz{
  static public var _(default,never) = MacroContextLift;
  public final pos          : Pos;
  public final context      : Context;
  public final definitions  : StringMap<HTypeDefinition>;
  public final show         : haxe.macro.Printer; 

  public function new(context,pos){
    super();
    this.context      = context;
    this.pos          = pos;
    this.definitions  = new StringMap();
    this.show         = new haxe.macro.Printer();
  }
  // public function has(def:HTypeDefinition){
  //   return definitions.exists(identity.toString());
  // }
  // public function put(def:HTypeDefinition){
  //   this.set(def.)
  // }
}
class MacroContextLift{
  /**
    Returns the Type of the field of the key when TLink
  **/
  static public function toHaxeTypePath(self:stx.schema.core.Type,state:MacroContext):Res<haxe.macro.Expr.TypePath,SchemaFailure>{
    return switch(self.data){
      case TData(t)       : __.accept(t.pop().toHaxeTypePath());
      case TAnon(t)       : __.accept(t.pop().toHaxeTypePath());
      case TRecord(t)     : __.accept(t.pop().toHaxeTypePath());
      case TGeneric(t)    : __.accept(t.pop().toHaxeTypePath());
      case TUnion(t)      : __.accept(t.pop().toHaxeTypePath());
      case TLink(t)       :
        final type    = t.pop(); 
        type.lookup().flat_map(
          inverse_type -> switch(type.relation){
            case HAS_MANY : 
              toHaxeTypePath(inverse_type,state).map(
                inverse_type -> ({
                  pack    : ['stx','nano'],
                  name    : 'Cluster',
                  params  : [TPType(TPath(inverse_type))]
                }:haxe.macro.Expr.TypePath)
              );
            default     : 
              toHaxeTypePath(inverse_type,state);
          }
        );
      case TEnum(t)       : __.accept(t.pop().toHaxeTypePath());
      case TLazy(t)       : 
        __.option(t.pop())
          .flat_map(x -> __.option(x.type))
          .resolve(f -> f.of(E_Schema_LazyTypeEmpty))
          .flat_map(toHaxeTypePath.bind(_,state));
      case TMono          : __.reject(__.fault().of(E_Schema_UnexpectedMono));
    };
  }
}