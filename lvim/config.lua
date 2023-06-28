-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
--

lvim.transparent_window = true
lvim.keys.normal_mode["<Tab>"] = ":bn<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<S-X>"] = ":BufferKill<CR>"
lvim.keys.normal_mode["gR"] = ":lua vim.lsp.buf.rename()<CR>"
lvim.keys.insert_mode["<C-M>"] = "<esc>:lua vim.lsp.buf.hover()<CR>a"
lvim.keys.normal_mode["ge"] = ":lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["gE"] = ":lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.visual_mode["ge"] = ":lua vim.diagnostic.goto_next()<CR>"
lvim.keys.visual_mode["gE"] = ":lua vim.diagnostic.goto_prev()<CR>"
-- disable pg up and down
vim.keymap.set('n', '<PageUp>', '<nop>')
vim.keymap.set('n', '<PageDown>', '<nop>')
vim.keymap.set('i', '<PageUp>', '<nop>')
vim.keymap.set('i', '<PageDown>', '<nop>')
vim.keymap.set('v', '<PageUp>', '<nop>')
vim.keymap.set('v', '<PageDown>', "<nop>")

vim.keymap.set('n', 'S', ":%s//g<Left><Left>")

lvim.format_on_save = true
vim.g.tabstop = 4
vim.g.softtabstop = 0
vim.g.shiftwidth = 0
vim.g.tabexpand = true

lvim.plugins = {
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local status_ok, rust_tools = pcall(require, "rust-tools")
      if not status_ok then
        return
      end

      local opts = {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            --border = {
            --        { "╭", "FloatBorder" },
            --        { "─", "FloatBorder" },
            --        { "╮", "FloatBorder" },
            --        { "│", "FloatBorder" },
            --        { "╯", "FloatBorder" },
            --        { "─", "FloatBorder" },
            --        { "╰", "FloatBorder" },
            --        { "│", "FloatBorder" },
            --},
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require "rust-tools"
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "ga", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
          on_init = require("lvim.lsp").common_on_init,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy"
              }
            }
          },
        },
      }
      rust_tools.setup(opts)
    end,
    ft = { "rust", "rs" },
  },
}



if vim.g.neovide then
  vim.o.guifont = "Source Code Pro:h9"
  vim.g.neovide_scale_factor = 0.6
  vim.g.neovide_transparency = 0.6
  lvim.keys.normal_mode["<C-S-P>"] = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05<CR>"
  lvim.keys.normal_mode["<C-S-M>"] = ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05<CR>"
end
