package stx.schema.type;

interface UnionTypeApi extends DataTypeApi{
  final lhs : SType;
  final rhs : SType;
}
class UnionTypeCls extends ConcreteType implements UnionTypeApi {
  public final lhs : SType;
  public final rhs : SType;
  public function new(ident,lhs,rhs,?validation){
    super(ident,validation);
    this.lhs = lhs;
    this.rhs = rhs;
  }
  override public function get_identity(){
    return Identity.make(
      this.ident,
      Some(lhs.identity),
      Some(rhs.identity)
    );
  }
  public function register(state:TypeContext):SType{
    var next : UnionType    = null;
    final t                 = Ref.make(
      () -> next
    );
    state.put(STUnion(t));

    final l   = state.get(lhs.identity).fudge(__.fault().of(E_Schema_IdentityUnresolved(lhs.identity)));
    final r   = state.get(rhs.identity).fudge(__.fault().of(E_Schema_IdentityUnresolved(rhs.identity)));
  
    next = new UnionTypeCls(this.ident,l,r);
    return STUnion(next);
  }
  public function toSType():SType{
    return STUnion(Ref.pure((this:UnionType)));
  }
  public function toString(){
    return this.identity.toString();
  }
}
@:using(stx.schema.type.UnionType.UnionTypeLift)
@:forward abstract UnionType(UnionTypeApi) from UnionTypeApi to UnionTypeApi{
  public function new(self) this = self;
  @:noUsing static public function lift(self:UnionTypeApi):UnionType return new UnionType(self);

  public function prj():UnionTypeApi return this;
  private var self(get,never):UnionType;
  private function get_self():UnionType return lift(this);

  @:noUsing static public function make(ident,lhs,rhs,?validation){ 
    return lift(new UnionTypeCls(ident,lhs,rhs,validation));
  }
}
class UnionTypeLift{
  static public function main(self:UnionType,state:GTypeContext){
    // final g     = __.g();
    // final expr  = g.expr();
    // final lhs_type_path   = GTypeContext._.toSType()Path(self.lhs,state);
    // final rhs_type_path   = GTypeContext._.toSType()Path(self.rhs,state);
    // //if(state.definitions)
    // return lhs_type_path.zip(rhs_type_path).flat_map(
    //   __.decouple((l:GTypePath,r:GTypePath) -> {
    //     final underlying_type = g.type_path().Make(
    //       'Either','std.haxe.extern'.split('.'),
    //       null,[l,r].map(x -> x.toSType()Param())
    //     );
    //     final abstract_ident                    = Ident.make(self.name,self.pack);
    //     final abstract_type_path                = g.type_path().Make(self.name,self.pack); 
    //     final abstract_type_ct                  = abstract_type_path.toComplexType();
    //     final hl                                = l.toComplexType();
    //     final hr                                = r.toComplexType();

    //     final from_lhs_name   = 'from${Chars.lift(l.name).capitalize_first_letter()}';
    //     final from_lhs        = g.method().Make(
    //         arg  -> [arg.Make('self',hl)],
    //         abstract_type_ct,
    //         e -> e.Return(e.Call(e.Path('lift'),[e.Path('self')]))
    //     );
    //     final from_rhs_name   = 'from${Chars.lift(r.name).capitalize_first_letter()}';
    //     final from_rhs        = g.method().Make(
    //         arg  -> [arg.Make('self',hr)],
    //         abstract_type_ct,
    //         e -> e.Return(e.Call(e.Path('lift'),[e.Path('self')]))
    //     );
    //     final lhs_member      = g.field().Make(from_lhs_name,ftype -> ftype.Fun(from_lhs),acc -> [acc.Public(),acc.Static()]);
    //     final rhs_member      = g.field().Make(from_rhs_name,ftype -> ftype.Fun(from_rhs),acc -> [acc.Public(),acc.Static()]);
        
    //     final abstract_type   = __.accept(__.couple(lhs_member,rhs_member)).flat_map(
    //       __.decouple(
    //         (l:GField,r:GField) -> {
    //           final methods         = [l,r];
    //           final l_accessors     = Res.bind_fold(
    //             self.lhs.fields,
    //             (next:Field,memo:Cluster<GField>) -> next.fetchGField_shim(state).map(memo.concat),
    //             [].imm()
    //           );
    //           final r_accessors     = Res.bind_fold(
    //             self.rhs.fields,
    //             (next:Field,memo:Cluster<GField>) -> next.fetchGField_shim(state).map(memo.concat),
    //             [].imm()
    //           );
    //           final accessors       = l_accessors.zip_with(r_accessors,(x,y) -> Cluster._.concat(x,y));

    //           return 
    //             __.accept(methods)
    //               .zip_with(accessors,(x,y) -> Cluster._.concat(x,y));
    //         }  
    //       )
    //     ).map(
    //       (fields:Cluster<GField>) -> {
    //         final abstract_type   = g.type().Make(
    //           abstract_ident.name,
    //           abstract_ident.pack,
    //           tdkind -> tdkind.Abstract(
    //             underlying_type.toComplexType(),
    //             [hl,hr],
    //             [hl,hr]
    //           ),
    //           fields
    //         );
    //         return abstract_type;
    //       }
    //     );
    //     return abstract_type;
    //   })
    // );
    return throw UNIMPLEMENTED;
  }
  static public function leaf(self:UnionType,state:GTypeContext){
   //.final type =  
    return throw UNIMPLEMENTED;
  }
}