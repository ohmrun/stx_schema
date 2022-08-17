package stx.schema;

interface WithIdentityApi{
  public var identity(get,null):Identity;
  private function get_identity():Identity;
}
abstract class WithIdentityCls implements WithIdentityApi{
  public var identity(get,null):Identity;
  abstract private function get_identity():Identity;
}