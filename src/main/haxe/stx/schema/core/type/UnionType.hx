package stx.schema.core.type;

interface UnionTypeApi extends DataTypeApi{
  final lhs : Type;
  final rhs : Type;
}
class UnionTypeCls extends DataTypeCls implements UnionTypeApi {
  public final lhs : Type;
  public final rhs : Type;
  public function new(name,pack,lhs,rhs,?validation){
    super(name,pack,validation);
    this.lhs = lhs;
    this.rhs = rhs;
  }
  override public function identity(){
    return Identity.make(
      Ident.make(name,pack),
      Some(lhs.identity()),
      Some(rhs.identity())
    );
  }
  public function register(state:Context):Type{
    var next : UnionType    = null;
    final t                 = Ref.make(
      () -> next
    );
    state.put(TUnion(t));

    final l   = state.get(lhs.identity()).fudge(__.fault().of(E_Schema_IdentityUnresolved(lhs.identity())));
    final r   = state.get(rhs.identity()).fudge(__.fault().of(E_Schema_IdentityUnresolved(rhs.identity())));
  
    next = new UnionTypeCls(this.name,this.pack,l,r);
    return TUnion(next);
  }
  public function toString(){
    return this.identity().toString();
  }
}
@:using(stx.schema.core.type.UnionType.UnionTypeLift)
@:forward abstract UnionType(UnionTypeApi) from UnionTypeApi to UnionTypeApi{
  public function new(self) this = self;
  static public function lift(self:UnionTypeApi):UnionType return new UnionType(self);

  public function prj():UnionTypeApi return this;
  private var self(get,never):UnionType;
  private function get_self():UnionType return lift(this);

  @:noUsing static public function make(name,pack,lhs,rhs,?validation){ 
    return lift(new UnionTypeCls(name,pack,lhs,rhs,validation));
  }
}
class UnionTypeLift{
  #if macro
  static public function main(self:UnionType,state:MacroContext){
    final lhs_type_path   = MacroContext._.toHaxeTypePath(self.lhs,state);
    final rhs_type_path   = MacroContext._.toHaxeTypePath(self.rhs,state);
    //if(state.definitions)
    return lhs_type_path.zip(rhs_type_path).flat_map(
      __.decouple((l:HTypePath,r:HTypePath) -> {
        final underlying_type = HTypePath.make(
          'Either',['std','haxe','extern'],
          ([l,r]:Array<HTypeParam>)
        );
        final abstract_ident                    = Ident.make(self.name,self.pack);
        final abstract_type_path                = HTypePath.make(self.name,self.pack); 
        final abstract_type_ct : HComplexType   = abstract_type_path;
        final hl                                = (l:HComplexType);
        final hr                                = (r:HComplexType);

        final from_lhs_name   = 'from${Chars.lift(l.name).capitalize_first_letter()}';
        final from_lhs        = macro function(self:$hl):$abstract_type_ct{
          return lift(self);
        };
        final from_rhs_name   = 'from${Chars.lift(r.name).capitalize_first_letter()}';
        final from_rhs        = macro function(self:$hr):$abstract_type_ct{
          return lift(self);
        };
        //TODO @:from metadata
        final lhs_member      = (HExpr.fromExpr
          (from_lhs)).toFunction()
            .map(f -> Member.method(from_lhs_name,state.pos,true,f))
            .resolve(f -> f.of(E_Makro_ExprIsNotFunction))
            .errate(e ->(e:SchemaFailure));
        
        final rhs_member      = (HExpr.fromExpr
          (from_rhs)).toFunction()
            .map(f -> Member.method(from_lhs_name,state.pos,true,f))
            .resolve(f -> f.of(E_Makro_ExprIsNotFunction))
            .errate(e ->(e:SchemaFailure));
          
        final abstract_type   = lhs_member.zip(rhs_member).flat_map(
          __.decouple(
            (l:tink.macro.Member,r:tink.macro.Member) -> {
              l.isStatic = true;
              r.isStatic = true;
              final methods         = ([l,r]:Array<stx.makro.alias.StdField>);
              final l_accessors     = Res.bind_fold(
                self.lhs.fields,
                (next:Field,memo:Cluster<HField>) -> next.fetchHField_shim(state).map(memo.concat),
                [].imm()
              );
              final r_accessors     = Res.bind_fold(
                self.rhs.fields,
                (next:Field,memo:Cluster<HField>) -> next.fetchHField_shim(state).map(memo.concat),
                [].imm()
              );
              final accessors       = l_accessors.zip_with(r_accessors,(x,y) -> Cluster._.concat(x,y));

              return 
                __.accept(methods)
                  .zip_with(accessors,(x,y) -> Cluster._.concat(x,y));
            }  
          )
        ).map(
          (fields:Cluster<HField>) -> {
            final abstract_type   = HTypeDefinition.make(
              abstract_ident,
              fields,
              HTypeDefKind.Abstract(
                underlying_type,
                [hl,hr],
                [hl,hr]
              )
            );
            return abstract_type;
          }
        );
        return throw UNIMPLEMENTED;
      })
    );
  }
  static public function leaf(self:UnionType,state:MacroContext){
   //.final type =  
    return throw UNIMPLEMENTED;
  }
  static public function toComplexType(self:UnionType,state:MacroContext){
    return DataType._.toComplexType(self.prj(),state);
  }
  // static public function define_generic(self:UnionType,state:MacroContext){
  //   final inner_type_path = MacroContext._.toHaxeTypePath(self.type);
  //   return inner_type_path.flat_map(
  //     null
  //   );
  // } 
  #end
}