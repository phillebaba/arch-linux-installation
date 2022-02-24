require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true, 
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

_G.project_files = function()
  local ok = pcall(require"telescope.builtin".git_files, {})
  if not ok then 
    require"telescope.builtin".find_files({hidden = true, no_ignore = true}) 
  end
end
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua project_files()<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', 'lua require("telescope.builtin").help_tags()<cr>', { noremap = true, silent = true })
