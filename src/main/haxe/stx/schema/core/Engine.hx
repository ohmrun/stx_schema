package stx.schema.core;

typedef EngineDef<P,R,E> = (P -> R) -> (P -> Rejection<E>) -> (Void -> Res<R,E>);

abstract Engine<P,R,E>(EngineDef<P,R,E>) from EngineDef<P,R,E> to EngineDef<P,R,E>{
  public function new(self) this = self;
  @:noUsing static public function lift<P,R,E>(self:EngineDef<P,R,E>):Engine<P,R,E> return new Engine(self);

  public function prj():EngineDef<P,R,E> return this;
  private var self(get,never):Engine<P,R,E>;
  private function get_self():Engine<P,R,E> return lift(this);
}