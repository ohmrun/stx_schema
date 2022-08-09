package stx.schema.test;

class TableTypeTest extends TestCase{
  public function _test_type(){
    final schema      = TestTypes.one();
    // final typer       = TyperContext.make(schema);
    // try{
    //   typer.type();
    // }catch(e:haxe.Exception){
    //   trace(e.stack);
    // }
  }
  public function test_leaf(){
    final schema      = TestTypes.one();
    // final typer       = TyperContext.make(schema);
    //       typer.type();
    // final types       = typer.context.register;
    // final user_type   = types.get('User(_,_)');
    // final gtype_ctx   = new GTypeContext(typer.context);
    // for(type in types){
    //   switch(type.data){
    //     case STRecord(t) :
    //       // try{
    //       //   final tdef = t.pop().getMainTypeDefinition();
    //       //   trace(tdef.toSource());
    //       // }catch(e:haxe.Exception){
    //       //   trace(e.stack);
    //       //   __.log().fatal(e.toString());
    //       //   __.crack(e);
    //       // }
    //     default : 
    //   }
    // }
    // final states_type = types.get('human.States(_,_)');
    // trace(states_type.data);
    // switch(states_type.data){
    //   case TEnum(t) :
    //     try{
    //       final type = t.pop();
    //       trace(type.getTypeDefinition().toSource());
    //     }catch(e:haxe.Exception){
    //       trace(e.stack);  
    //     }
    //   default : 
    //     trace("NOPE");
    // }
    //trace(states_type);
  }
}