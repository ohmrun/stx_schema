//@:stx.schema 
typedef User = {
  var first_name  : String;
  var last_name   : String;
  var email       : Email;
}
abstract ValidateEmail(Bool){}

@stx.schema.validate.ValidateEmail
abstract Email(String) from String{
   
}
//@:schema typedef