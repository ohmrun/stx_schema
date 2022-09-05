package stx.schema;

class Templater{
  static function e0(field,type) { return E_Schema_NoTemplateFieldInType(field,type); }

  //Pledge.make(__.reject(f -> f.of(E_Schema_RequireFieldsDeclaration(template))));
  static public function whittle(type:SType,template:Template,state:State):Res<SType,SchemaFailure>{  
    return apply(type,template,state);
  }
  static function get_field(type:SType,string:String,state:State):Option<Field>{
    return type.fields.search(x -> x.name == string);
  }
  static function apply(type:SType,template:Template,state:State):Res<SType,SchemaFailure>{
    __.log().trace('apply ${type}');
    return step(template,type,state).adjust(
      opt -> opt.fold(
        ok -> __.accept(ok),
        () -> __.reject(f -> f.of(E_Schema_Dynamic("foobar")))
      )
    );
  }
  static function obj(template:Template,type:SType,state:State):Res<Cluster<Field>,SchemaFailure>{
    __.log().trace('obj $type $template');
    return switch(template){
      case Cons(PLabel(s),Cons(PGroup(g),rest)) : 
        switch(type.data){
          case STAnon(_) | STRecord(_) | STLink(_): 
            get_field(type,s,state).fold(
              ok -> {
                __.log().trace('iter : ${ok}');
                // return switch(ok.type){}
                return apply(ok.type,g,state).flat_map(type -> __.accept([Field.make(s,type)].imm())); 
              },
              () -> __.reject(f -> f.of(e0(s,type)))
            ).flat_map(
              (fields) -> obj(rest,type,state).map(arr -> fields.concat(arr))
            );
          default : __.reject(f -> f.of(e0(s,type)));
        }
      case Cons(PLabel(s),rest)                 : 
        __.log().trace('${type.data} $rest');
        switch(type.data){
          case STMono | STScalar(_) | STEnum(_) : 
            __.accept([Field.make(s,type)]);
          case STAnon(_) | STRecord(_) : 
            get_field(type,s,state).resolve(f -> f.of(e0(s,type)))
             .flat_map(
                field -> {
                  trace(field.type);
                  return switch(field.type.data){
                    case STLink(l) : 
                      final lI = l.pop();
                      __.accept(switch(lI.relation){
                        case HAS_MANY : Field.make(field.name,SType.Array(state.context.create(),SType.ID(state.context.create())));
                        default       : Field.make(field.name,SType.ID(state.context.create()));
                      });
                    default : __.accept(field);
                  }
                }
            ).flat_map(
              (field) -> obj(rest,type,state).map(arr -> [field].imm().concat(arr))
            );
          case STLink(_) : 
            __.accept([Field.make(s,SType.ID(state.context.create()))]);
          default : __.reject(f -> f.of(e0(s,type)));
        }
      case Nil:
        __.accept([]);
      default : 
        __.log().trace('${template}');
        __.reject(f -> f.of(E_Schema_Dynamic("encountered error state")));
    }
  }
  static function step(template:Template,type:SType,state:State):Res<Option<SType>,SchemaFailure>{
    __.log().trace(('step $type $template'));
    return switch(type.data){
      case STScalar(_)                 : __.accept(Some(type));
      case STAnon(_) | STRecord(_)     : 
        obj(template,type,state).map(
          fields -> Some(AnonType.make(state.context.create(),fields).toSType())
        );
      case STEnum(_) : 
        __.accept(Some(type));
      case STGeneric(t)     :
        apply(t.pop().type,template,state).map(
          type -> Some(t.pop().copy(state.context.create(),null/** TODO name **/,type).toSType())
        );
      case STUnion(t)       :
        Res.bind_fold(
          t.pop().rest,
          (n:SType,m:Cluster<SType>) -> {
            return step(template,n,state).map(
              opt -> opt.fold(
                m.snoc,
                () -> m
              )
            );
          },
          []
        ).adjust(
          (types) -> types.is_defined().if_else(
            () -> __.accept(Some(t.pop().copy(state.context.create(),types).toSType())),
            () -> __.reject(f -> f.of(E_Schema_Dynamic("no candidates")))
          )
        );
      case STLink(t)        :
        __.log().trace('link: $template');      
        apply(t.pop().into,template,state).flat_map(
          type -> {
            return __.accept(Some(switch(t.pop().relation){
              case HAS_MANY : SType.Array(state.context.create(),type);
              default       : type;
            }));
          }
        );
        // switch(template){
        //   case Nil | Cons(PLabel(_),_) : __.accept(Some(SType.ID(state.context.create())));
        //   default : 
        // }
      case STLazy(f)        : step(template,f.pop().type,state);
      case STMono           : __.accept(None);
    }
  }
}