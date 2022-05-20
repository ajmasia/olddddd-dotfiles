local completions_status_ok, completions = pcall(require, "cmp")
if not completions_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local icons = require "core.icons"

local kind_icons = icons.kind

completions.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = completions.mapping.select_prev_item(),
    ["<C-j>"] = completions.mapping.select_next_item(),
    ["<C-b>"] = completions.mapping(completions.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = completions.mapping(completions.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = completions.mapping(completions.mapping.complete(), { "i", "c" }),
    -- ["<C-y>"] = completions.config.disable, -- Specify `completions.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = completions.mapping {
      i = completions.mapping.abort(),
      c = completions.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = completions.mapping.confirm { select = true },
    ["<Tab>"] = completions.mapping(function(fallback)
      if completions.visible() then
        completions.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = completions.mapping(function(fallback)
      if completions.visible() then
        completions.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

      if entry.source.name == "cmp_tabnine" then
        -- if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
        -- menu = entry.completion_item.data.detail .. " " .. menu
        -- end
        vim_item.kind = icons.misc.Robot
      end
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- NOTE: order matters
      vim_item.menu = ({
        -- nvim_lsp = "[LSP]",
        -- nvim_lua = "[Nvim]",
        -- luasnip = "[Snippet]",
        -- buffer = "[Buffer]",
        -- path = "[Path]",
        -- emoji = "[Emoji]",

        nvim_lsp = "",
        nvim_lua = "",
        luasnip = "",
        buffer = "",
        path = "",
        emoji = "",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "cmp_tabnine" },
    { name = "path" },
    { name = "emoji" },
  },
  confirm_opts = {
    behavior = completions.ConfirmBehavior.Replace,
    select = false,
  },
  -- documentation = true,
  documentation = {
  	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
}

