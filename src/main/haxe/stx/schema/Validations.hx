package stx.schema;

abstract Validations(Array<Validation>) from Array<Validation> to Array<Validation>{
  public function lfold(value:Dynamic,schema:Schema){
    return this.lfold(
      (next:Validation,memo:Report<SchemaFailure>) -> memo.merge(next.lfold(value,schema)),
      __.report()
    );
  }
}