package stx.schema.core;

class Field extends WithIdentityCls{
  public final name : String;
  public final type : SType;

  public function new(name,type){
    this.name = name;
    this.type = type;
  }
  public function get_identity(){
    return type.identity;
  }
  static public function make(name,type){
    return new Field(name,type); 
  }
}