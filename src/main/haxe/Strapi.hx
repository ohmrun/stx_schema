typedef Attribute = {
  final type : String;
}
typedef RelationalAttribute = Attribute & {
  final ?relation     : String;
  final ?target       : String;

  final ?inversedBy   : String;//owner of relation
  final ?mappedBy     : String;//points ot owner
}
