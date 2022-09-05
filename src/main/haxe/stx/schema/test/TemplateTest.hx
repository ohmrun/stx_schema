package stx.schema.test;

@stx.test.async
class TemplateTest extends TestCase{
  function EQ(){
    return SType._.eq();
  }
  var state(get,null):State;
  public function get_state(){
    return state == null ? state = State.make(TestTypes.two(),new Context()) : state ;
  }
  function artist_identity(){
    return Identity.make(Ident.make('Artist',[]),[]);
  }
  public function whittle(t,template,s){
    return Templater.whittle(t,template,s);
  }
  public function test(async:Async){
    state.reply().handle(
      x -> {
        trace(x);
        for(ok in x){
          for(v in ok){
            trace(v.fields);
          }
        }
        async.done();
      }
    );
  }
  public function test_select_one_scalar_typed(async:Async){
    state.reply().map(
      x -> x.search(x -> x.identity.equals(artist_identity())).fudge()
    ).handle(
        (type) -> {
          for (t in type){
            final template = select_one_scalar_typed();
            final next     = whittle(t,template,state);
            final test     = SType.AnonType(
              state.context.create(),
              [
                Field.make('name',SType.String(state.context.create()))
              ]
            );
            for(v in next){
              eq(v,test,EQ());
            }
          }
          async.done();
        }
    );
  }
  public function test_select_two_scalar_typed(async:Async){
    state.reply().map(
      x -> x.search(x -> x.identity.equals(artist_identity())).fudge()
    ).handle(
      (type) -> {
        for (t in type){
          final template = select_two_scalar_typed();
          final next     = whittle(t,template,state);
          trace(next);
          final test     = SType.AnonType(
            state.context.create(),
            [
              Field.make('name',SType.String(state.context.create())),
              Field.make('real_name',SType.String(state.context.create()))
            ]
          );
          for(v in next){
            eq(v,test,EQ());
          }
          async.done();
        }
      }
    );
  }
  public function select_one_object(){
    return Cons(PLabel('tracks'),Cons(PGroup(Cons(PLabel('name'),Nil)),Nil));
  }
  public function test_select_one_object(async:Async){
    state.reply().map(
      x -> x.search(x -> x.identity.equals(artist_identity())).fudge()
    ).handle(
      (type) -> {
        for (t in type){
            final template = select_one_object();
            final next     = whittle(t,template,state);
            final test     = SType.AnonType(
              state.context.create(),
              [
                Field.make('tracks',
                  SType.Array(state.context.create(),
                    SType.AnonType(
                      state.context.create(),
                      [
                        Field.make('name',SType.String(state.context.create()))
                      ]
                    )
                  )
                )
              ]
            );
            for(v in next){
              eq(v,test,EQ());
            }
          trace(next);
          async.done();
        }
      }
    );
  }
  public function select_one_object_object(){
    return Cons(PLabel('tracks'),Cons(PGroup(Cons(PLabel('album'),Cons(PGroup(Cons(PLabel('year'),Cons(PLabel('name'),Nil))),Nil))),Nil));
  }
  public function test_select_one_object_object(async:Async){
    state.reply().map(
      x -> x.search(x -> x.identity.equals(artist_identity())).fudge()
    ).handle(
      (type) -> {
        for (t in type){
            final template = select_one_object_object();
            final next     = whittle(t,template,state);
            final test     = SType.AnonType(
              state.context.create(),
              [
                Field.make('tracks',
                  SType.Array(state.context.create(),
                    SType.AnonType(
                      state.context.create(),
                      [
                        Field.make('album',
                          SType.Array(state.context.create(),
                            SType.Null(state.context.create(),
                              SType.AnonType(
                                state.context.create(),[
                                  Field.make('year',SType.Int(state.context.create())),
                                  Field.make('name',SType.String(state.context.create()))
                                ]
                              )
                            )
                          )
                        )
                      ]
                    )
                  )
                )
              ]
            );
            for(v in next){
              eq(v,test,EQ());
            }
            trace(next);
          async.done();
        }
      }
    );
  }

  public function select_ids(){
    return Cons(PLabel('tracks'),Cons(PLabel('name'),Nil));
  }
  public function test_select_ids(async:Async){
    state.reply().map(
      x -> x.search(x -> x.identity.equals(artist_identity())).fudge()
    ).handle(
      (type) -> {
        for (t in type){
            final template    = select_ids();
            final next        = whittle(t,template,state);
            final value       = SType.AnonType(
              state.context.create(),
              [
                Field.make('tracks',SType.Array(state.context.create(),SType.ID(state.context.create()))),
                Field.make('name',SType.String(state.context.create()))
              ]
            );
            for(v in next){
              this.eq(v,value,EQ());
            }
          trace(next);
          async.done();
        }
      }
    );
  }
  public function test_select_union(async:Async){
    final ts  = TestTypes.two();
    final s   = State.make(ts,new Context());
      s.reply().map(
        x -> {
          return x.search(
            (x) -> {
              final id = 
                Identity.make(
                  Ident.make('Union',['std']),
                  [
                    Identity.make(Ident.make('Artist',[]),[]),
                    Identity.make(Ident.make('Band',[]),[])
                  ]
                );
              final ok = x.identity.equals(id);
              return ok;
            }
          ).fudge();
        }
      ).handle(
          (type) -> {
            for (t in type){
              final template = select_one_from_union();
              final next     = whittle(t,template,s);
              trace(next);
            }
            async.done();
          }
      );
  }
  
  public function select_one_scalar_typed():Template{
    return Cons(PLabel('name'),Nil);
  }
  public function select_two_scalar_typed():Template{
    return Cons(PLabel('name'),Cons(PLabel('real_name'),Nil));
  }
  public function select_one_object_and_one_field(){
    return Cons(PLabel('tracks'),Cons(PGroup(Cons(PLabel('name'),Nil)),Cons(PLabel('name'),Nil)));
  }
  public function select_one_from_union(){
    return Cons(PLabel('name'),Nil);
  } 
}