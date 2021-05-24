package stx.schema;

typedef SchemaEnumDeclarationDef = SchemaDeclarationDef & {
  final constructors : Array<String>;
}
@:forward abstract SchemaEnumDeclaration(SchemaEnumDeclarationDef) from SchemaEnumDeclarationDef to SchemaEnumDeclarationDef{
  static public var _(default,never) = SchemaEnumDeclarationLift;
  public function new(self) this = self;
  static public function lift(self:SchemaEnumDeclarationDef):SchemaEnumDeclaration return new SchemaEnumDeclaration(self);

  static public function make(name,pack,constructors,?validation){
    return lift({
      name          : name,
      pack          : pack,
      constructors  : constructors,
      validation    : _.validation.concat(__.option(validation).defv([]))
    });
  }

  public function prj():SchemaEnumDeclarationDef return this;
  private var self(get,never):SchemaEnumDeclaration;
  private function get_self():SchemaEnumDeclaration return lift(this);
} 
class SchemaEnumDeclarationLift{
  static public var validation(get,null) : Validations;
  static public function get_validation(){
    return [ValidationExpr(check_constructor)];
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