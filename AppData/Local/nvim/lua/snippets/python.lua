local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node

local function generic_pdoc(ilevel, args)
    local nodes = { t({ '"""', string.rep('\t', ilevel) }) }
    nodes[#nodes + 1] = i(1, 'Small Description.')
    nodes[#nodes + 1] = t({ '', '', string.rep('\t', ilevel) })
    nodes[#nodes + 1] = i(2, 'Long Description')
    nodes[#nodes + 1] = t({ '', '', string.rep('\t', ilevel) .. 'Args:' })

    local a = {}
    if args[1] then
        a = vim.tbl_map(function(item)
            local trimed = vim.trim(item)
            return trimed
        end, vim.split(
        args[1][1],
        ',',
        true
        ))
    end

    for idx, v in pairs(a) do
        nodes[#nodes + 1] = t({ '', string.rep('\t', ilevel + 1) .. v .. ': ' })
        nodes[#nodes + 1] = i(idx + 2, 'Description For ' .. v)
    end

    return nodes, #a
end

local function pyfdoc(args, _, ostate)
    local nodes, a = generic_pdoc(1, args)
    nodes[#nodes + 1] = c(a + 2 + 1, { t(''), t({ '', '', '\tReturns:' }) })
    nodes[#nodes + 1] = i(a + 2 + 2)
    nodes[#nodes + 1] = c(a + 2 + 3, { t(''), t({ '', '', '\tRaises:' }) })
    nodes[#nodes + 1] = i(a + 2 + 4)
    nodes[#nodes + 1] = t({ '', '\t"""', '\t' })
    local snip = sn(nil, nodes)
    snip.old_state = ostate or {}
    return snip
end

local function generate_docstring(funcdef, _, ostate, _)
    local parser = vim.treesitter.get_string_parser(funcdef[1][1], "python")
    local tstrees = parser:parse()
    local tree = tstrees[1]
    local module = tree:root()
    local func = module:child(0)
    local pp = ""
    print(func["name"])
    for i = 1, func:named_child_count() do
        local node = func:named_child(i - 1)
        pp = pp .. ", " .. node:type()
    end
    local params = func:child(0)

    local args = {}
    if params then
        for parm in params:iter_children() do
            print(parm)
            args[#args+1] = parm
        end
    end
    local nodes, _ = generic_pdoc(2, args)
    nodes[#nodes + 1] = t({ '', '\t\t"""', '' })
    local snip = sn(nil, nodes)
    snip.old_state = ostate or {}
    return snip
end

return {
    s({ trig = 'fn', dscr = 'Documented Function Structure' }, {
        sn(1, {
            t("def "),
            i(1, "func"),
            t("("),
            i(2),
            t(") -> "),
            i(3, "rtype"),
            t({ ":", "\t" }),
        }),
        d(2, generate_docstring, 1, { }),
    }),
}
