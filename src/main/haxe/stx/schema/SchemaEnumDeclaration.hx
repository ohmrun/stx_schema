package stx.schema;

typedef SchemaEnumDeclarationDef = SchemaDeclarationDef & {
  final constructors : Cluster<String>;
}
@:using(stx.schema.SchemaEnumDeclaration.SchemaEnumDeclarationLift)
@:forward abstract SchemaEnumDeclaration(SchemaEnumDeclarationDef) from SchemaEnumDeclarationDef to SchemaEnumDeclarationDef{
  static public var _(default,never) = SchemaEnumDeclarationLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:SchemaEnumDeclarationDef):SchemaEnumDeclaration return new SchemaEnumDeclaration(self);

  @:noUsing static public function make(ident:Ident,constructors,?validation){
    return lift({
      id            : Identity.fromIdent(ident),
      constructors  : constructors,
    validation    : _.validation.concat(__.option(validation).defv(Cluster.unit()))
    });
  }
  @:noUsing static public function make0(name:String,pack,constructors,?validation){
    return make(Ident.make(name,pack),constructors,validation);
  }
  public function identity(){
    return this.id;  
  }
  public function prj():SchemaEnumDeclarationDef return this;
  private var self(get,never):SchemaEnumDeclaration;
  private function get_self():SchemaEnumDeclaration return lift(this);

  public function toString(){
    final thiz = identity().toString();
    return '$thiz(${this.constructors.join(",")})';
  }
} 
class SchemaEnumDeclarationLift{
  static public function resolve(self:SchemaEnumDeclaration,state:TyperContext):Schema{
    state.put(SchEnum(self));
    return SchEnum(self);
  }
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return Cluster.lift([ValidationExpr(check_constructor)]);
  } 
  static private var check_constructor = Script.parser().parseString("
    function (self:Dynamic,type:Schema){ 
      return switch(type){
        case SchEnum(def) : 
          var ok = false;
            for(v in def.constructors){
              ok = v == self;
              if(ok){
                break;
              }
            }
            if(ok){
              __.report();
            }else{
              __.report(E_Schema_EnumValueError(def.constructors,self));
            }
        default :  __.report(E_Internal('Incorrect Type'));
      }
    }
  ");
  /**
    Creates a GTypeDeclaration that declares the structure of self:SchemaEnumDeclaration.
  **/
  static public inline function to_self_constructor(self:SchemaEnumDeclaration){
    final e = __.g().expr();
    return __.g().expr().Call(
      e.Path("stx.schema.SchemaEnumDeclaration.make"),
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