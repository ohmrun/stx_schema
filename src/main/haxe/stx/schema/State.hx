package stx.schema;

class State{
  public final sources    : Cluster<Schema>;
  public final context    : Context;
  public final namespace  : Way;

  static public function make(sources,context,?namespace){
    return new State(
      sources.concat([
        (SchScalar(stx.schema.declare.term.SchemaBool.make())),
        (SchScalar(stx.schema.declare.term.SchemaFloat.make())),
        (SchScalar(stx.schema.declare.term.SchemaInt.make())),
        (SchScalar(stx.schema.declare.term.SchemaString.make())),
        (SchScalar(stx.schema.declare.term.SchemaDate.make())),
      ]),
      context,
      namespace
    );
  }
  private function new(sources,context,?namespace){
    this.sources    = sources;
    this.context    = context;
    this.namespace  = __.option(namespace).defv(Way.unit());
  }
  public function copy(?sources:Cluster<Schema>,?context:Context,?namespace){
    return new State(
      __.option(sources).defv(this.sources),
      __.option(context).defv(this.context),
      __.option(namespace).defv(this.namespace)
    );
  }
  public function with_source(source){
    return copy(sources.snoc(source));
  }
  public function with_namespace(namespace){
    return copy(null,null,namespace);
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
  public function search(key:Identity){
    __.log().trace('search schema: $key');
    return sources.search(
      (x) -> {
        __.log().trace('$x');
        return x.identity.equals(key);
      }
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