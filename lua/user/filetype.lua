vim.g.do_filetype_lua=1
vim.filetype.add({
  extension = {
    txt = function(_, _)
      local filename =  vim.fn.expand('%:t:r')
      if filename:match('%d') then
        return "release-note"
      end
      return "txt"
    end,
  }
})
