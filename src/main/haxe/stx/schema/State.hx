package stx.schema;

class State{
  public final sources : Cluster<Schema>;
  public final context : Context;

  public function new(sources,context){
    this.sources = sources.concat([
      (SchScalar(stx.schema.declare.term.SchemaBool.make())),
      (SchScalar(stx.schema.declare.term.SchemaFloat.make())),
      (SchScalar(stx.schema.declare.term.SchemaInt.make())),
      (SchScalar(stx.schema.declare.term.SchemaString.make())),
    ]);
    this.context = context;
  }
  public var threshold(get,null):ThresholdSet<SType>;
  private function get_threshold():ThresholdSet<SType>{
    return RedBlackSet.make(
      context.satisfies.toComparable()
    );
  }
  public function obtain(key:Identity,threshold:ThresholdSet<SType>){
    return context.obtain(key.canonical(),threshold);
  }
  public function put(v:SType):Bool{
    return context.bestow(v.identity.canonical(),v);
  }
  public function schema(key:Identity){
    return sources.search(
      (x) -> x.identity.equals(key)
    );
  }
  public function reply(){
    trace('reply: $sources');
    return Pledge.bind_fold(
      sources,
      (next:Schema,memo:Cluster<SType>) -> {
        //trace(next);
        return new stx.schema.type.Registration().register_schema(next,this).map(
          (x) -> {
            //trace(x);
            return memo.snoc(x);
          }
        );
      },
      []
    );
  }
}