local c3p = require("coq_3p")

c3p({
  {
    src = "nvimlua",
    short_name = "nLUA",
    conf_only = true,
  },
  { src = "vimtex", short_name = "vTEX" },
  { src = "orgmode", short_name = "ORG" }
})
