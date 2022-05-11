package stx.schema.declare;

interface DeclareEnumSchemaApi extends DeclareSchemaApi{
  final constructors  : Cluster<String>;
  final ident         : Ident; 
}
class DeclareEnumSchemaCls implements DeclareEnumSchemaApi extends DeclareSchemaConcrete{
  public final constructors : Cluster<String>;
  public function new(ident,constructors,meta,validation){
    super(ident,meta);
    this.validation   = validation;
    this.constructors = constructors;
  }
  public function get_validation(){ return this.validation; } 
}
@:using(stx.schema.declare.DeclareEnumSchema.DeclareEnumSchemaLift)
@:forward abstract DeclareEnumSchema(DeclareEnumSchemaApi) from DeclareEnumSchemaApi to DeclareEnumSchemaApi{
  static public var _(default,never) = DeclareEnumSchemaLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclareEnumSchemaApi):DeclareEnumSchema return new DeclareEnumSchema(self);

  @:noUsing static public function make(ident:Ident,constructors,?meta,?validation){
    return lift(new DeclareEnumSchemaCls(
      ident,
      constructors,
      __.option(meta).defv(Empty),
      _.validation.concat(__.option(validation).defv(Cluster.unit()))
    ));
  }
  @:noUsing static public function make0(name:String,pack,constructors,?meta,?validation){
    return make(Ident.make(name,pack),constructors,meta,validation);
  }
  public function prj():DeclareEnumSchemaApi return this;
  private var self(get,never):DeclareEnumSchema;
  private function get_self():DeclareEnumSchema return lift(this);

  public function toString(){
    final thiz = this.id.toString();
    return '$thiz(${this.constructors.join(",")})';
  }
} 
class DeclareEnumSchemaLift{
  static public function resolve(self:DeclareEnumSchema,state:TyperContext):Schema{
    state.put(SchEnum(self));
    return SchEnum(self);
  }
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    //ValidationExpr(check_constructor)
    return Cluster.lift([]);
  } 
  //TODO
  // static private final check = __.g().expr().Function(
  //   farg -> [
  //     farg.Make('self',ctype -> ctype.fromString('Dynamic')),
  //     farg.Make('type',ctype -> ctype.fromString('stx.schema.Schema')),
  //   ],
  //   null,
  //   e -> e.Return(
  //     e.Switch(
  //       cases -> [
  //         cases.Make(
  //           [e]
  //         )
  //       ]
  //     )
  //   )
  // )
  // static private var check_constructor = Script.parser().parseString("
  //   function (self:Dynamic,type:Schema){ 
  //     return switch(type){
  //       case SchEnum(def) : 
  //         var ok = false;
  //           for(v in def.constructors){
  //             ok = v == self;
  //             if(ok){
  //               break;
  //             }
  //           }
  //           if(ok){
  //             __.report();
  //           }else{
  //             __.report(E_Schema_EnumValueError(def.constructors,self));
  //           }
  //       default :  __.report(E_Internal('Incorrect Type'));
  //     }
  //   }
  // ");
  /**
    Creates a GTypeDeclaration that declares the structure of self:DeclareEnumSchema.
  **/
  static public inline function denote(self:DeclareEnumSchema){
    final e = __.g().expr();
    return __.g().expr().Call(
      e.Path("stx.declare.schema.DeclareEnumSchema.make"),
      [
        e.Call(
          e.Path('stx.nano.Ident.make'),
          [
            e.Const(c -> c.String(self.id.name)),
            e.ArrayDecl(
              __.option(self.id.pack).defv(Way.unit()).prj().map(
                str -> e.Const( c -> c.String(str))
              )
            )
          ]          
        ),
        e.ArrayDecl(
          self.constructors.map(
            str -> e.Const(
              c -> c.Ident(str)
            )
          )
        )    
      ]
    );
  }
  // static public inline function toGTypeDefinition(){
  //   return stx.g.EnumAbstract.make(
  //     name          : self.name,
  //     pack          : self.pack,
  //     constructors  : self.constructors.map(
  //       ctr -> __.g().const(
  //         const -> { name : ctr, data : const.String(ctr) }
  //       )
  //     )
  //   );
  // }
}