(indeces "stx.schema.Test" "stx.schema.term.xsd.Test")
(
  "main" 
    include "stx.schema.test.TemplateTest"
)
(
  "comparison"
  include "stx.schema.test.ComparisonTest"
)
(
  "register"
  include "stx.schema.test.RegisterTest"
)
(
  "template"
    include (
      (
        "stx.schema.test.TemplateTest" 
        include "test_select_one_object_object"
      )
  )
)
(
  "xsd" include "stx.schema.term.xsd.test.XsdTest"
)