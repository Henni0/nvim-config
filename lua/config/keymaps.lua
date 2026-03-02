local ok, cmp = pcall(require, "cmp")
if not ok then
  return -- cmp is not installed, skip this keymap setup
end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if cmp.visible() then
    cmp.select_next_item()
  elseif has_words_before() then
    cmp.complete()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
  end
end)

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if cmp.visible() then
    cmp.select_prev_item()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
  end
end)
