(indeces "stx.schema.Test")
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
        include "test_select_union"
      )
  )
)