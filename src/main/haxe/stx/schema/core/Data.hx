package stx.schema.core;

enum DataSum{
  DSIdentity(id:Identity);
  DSSchema(schema:Schema);
  DSSType(type:SType);
  DSLiteral();
}