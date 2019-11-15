package stx.schema.pack;

@:enum abstract Relationship(String) from String to String{
  var ManyToMany  = "ManyToMany";
  var ManyToOne   = "ManyToOne";
  var OneToMany   = "OneToMany";
  var OneToOne    = "OneToOne";
}