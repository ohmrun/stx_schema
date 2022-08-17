package stx.schema;

class State{
  public final sources : Cluster<Schema>;
  public final context : Context;

  public function new(sources,context){
    this.sources = sources;
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
}