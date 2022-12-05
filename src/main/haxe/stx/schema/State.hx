package stx.schema;

class State{
  static public final DEFAULTS   : Cluster<Schema> = [
    (SchNative(stx.schema.declare.term.SchemaBool.make())),
    (SchNative(stx.schema.declare.term.SchemaFloat.make())),
    (SchNative(stx.schema.declare.term.SchemaInt.make())),
    (SchNative(stx.schema.declare.term.SchemaString.make())),
    (SchNative(stx.schema.declare.term.SchemaDate.make()))
  ];
  public final schema     : Schemas;
  public final context    : Context;
  public var namespace    : Way;

  static public function make(schema:Schemas,context,?namespace){
    return new State(
      schema.concat(DEFAULTS.prj()),
      context,
      namespace
    );
  }
  private function new(schema,context,?namespace){
    this.schema     = schema;
    this.context    = context;
    this.namespace  = __.option(namespace).defv(Way.unit());
  }
  public function with_namespace(fn:CTR<Way,Way>){
    return copy(null,null,fn.apply(this.namespace)); 
  }
  public function copy(?sources:Schemas,?context:Context,?namespace){
    return new State(
      __.option(schema).defv(this.schema),
      __.option(context).defv(this.context),
      __.option(namespace).defv(this.namespace)
    );
  }
  public var threshold(get,null):ThresholdSet<SType>;
  private function get_threshold():ThresholdSet<SType>{
    return RedBlackSet.make(
      @:privateAccess context.accretion.satisfies.toComparable()
    );
  }
  public function obtain(key:Identity){
    return context.obtain(key.canonical());
  }
  public function ref(identity:Identity):Signal<LVar<SType>>{
    return context.listen(identity.canonical());
  }
  public function put(v:SType):Bool{
    return context.bestow(v.identity.canonical(),HAS(v,false));
  }
  public function reply(){
    trace('reply: $schema');
    return Pledge.bind_fold(
      schema,
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