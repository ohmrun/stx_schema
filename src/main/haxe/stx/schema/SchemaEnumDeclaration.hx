package stx.schema;

typedef SchemaEnumDeclarationDef = SchemaDeclarationDef & {
  final constructors : Cluster<String>;
}
@:forward abstract SchemaEnumDeclaration(SchemaEnumDeclarationDef) from SchemaEnumDeclarationDef to SchemaEnumDeclarationDef{
  static public var _(default,never) = SchemaEnumDeclarationLift;
  public function new(self) this = self;
  static public function lift(self:SchemaEnumDeclarationDef):SchemaEnumDeclaration return new SchemaEnumDeclaration(self);

  static public function make(ident:Ident,constructors,?validation){
    return lift({
      id            : Identity.fromIdent(ident),
      constructors  : constructors,
      validation    : _.validation.concat(__.option(validation).defv(Cluster.unit()))
    });
  }
  static public function make0(name,pack,constructors,?validation){
    return make(Ident.make(name,pack),constructors,validation);
  }
  public function resolve(state:Schemata):Schema{
    state.put(this);
    return SchEnum(this);
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
}