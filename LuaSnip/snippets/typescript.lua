local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("ƒf", { -- arrow function
    t("export const "),
    i(1, "FunctionName"),
    t(" = () => {"),
    t({"", "\t"}), i(0),
    t({"", "}"})
  }),
  s("ƒfe", { -- forEach
    t("forEach(("),
    i(1, "val"),
    t(", _i) => {"),
    t({"", "\t"}), i(0),
    t({"", "})"})
  }),
}
