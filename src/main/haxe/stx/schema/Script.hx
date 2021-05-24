package stx.schema;

class Script{
  static public function interp(){
    var interp = new hscript.Interp();
        //interp.variables.set("ArrayLift")
    return interp;
  }
  static public function parser(){
    var parser = new hscript.Parser();
        parser.allowTypes = true; 
    return parser;
  }
}