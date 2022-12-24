require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "c_sharp", "comment", "cpp", "dart", "dockerfile",
    "elixir", "go", "graphql", "html", "java", "javascript", "jsdoc", "json",
    "json5", "kotlin", "latex", "lua", "perl", "php", "python", "ruby", "rust",
    "scala", "scss", "toml", "typescript", "vim", "vue", "yaml" },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

function _G.javascript_indent()
  local line = vim.fn.getline(vim.v.lnum)
  local prev_line = vim.fn.getline(vim.v.lnum - 1)
  if line:match('^%s*[%*/]%s*') then
    if prev_line:match('^%s*%*%s*') then
      return vim.fn.indent(vim.v.lnum - 1)
    end
    if prev_line:match('^%s*/%*%*%s*$') then
      return vim.fn.indent(vim.v.lnum - 1) + 1
    end
  end

  return vim.fn['GetJavascriptIndent']()
end

vim.cmd[[autocmd FileType javascript setlocal indentexpr=v:lua.javascript_indent()]]
