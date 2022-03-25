vim.cmd([[
  au BufRead,BufNewFile * if expand('%:t:r') =~ '\v<\d+>' | set filetype=release-note | endif
  ]])
