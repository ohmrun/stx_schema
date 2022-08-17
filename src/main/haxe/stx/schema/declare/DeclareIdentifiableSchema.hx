package stx.schema.declare;

interface DeclareIdentifiableSchemaApi extends DeclareSchemaApi{
  public var identity(get,null)     : stx.schema.core.Identity;
  public function get_identity():Identity;
}

abstract class DeclareIdentifiableSchemaCls implements DeclareIdentifiableSchemaApi extends DeclareSchemaCls{
  public function new(?validation,?meta){
    super(validation,meta);
  }
  public var identity(get,null)     : stx.schema.core.Identity;
  abstract public function get_identity():Identity;
}