-- Seashells, matching the global Pi theme in petalas/dotfiles.

vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' == 1 then vim.cmd 'syntax reset' end

vim.o.background = 'dark'
vim.g.colors_name = 'seashells'

local colors = {
  background = '#08131a',
  foreground = '#deb88d',
  cursor = '#fba02f',
  selection = '#1e4862',
  black = '#17384c',
  bright_black = '#424b52',
  red = '#d05023',
  bright_red = '#d38677',
  green = '#027b9b',
  bright_green = '#618c98',
  yellow = '#fba02f',
  bright_yellow = '#fdd29e',
  blue = '#1d4850',
  bright_blue = '#1abcdd',
  magenta = '#68d3f0',
  bright_magenta = '#bbe3ee',
  cyan = '#50a3b5',
  bright_cyan = '#86abb3',
  white = '#deb88d',
  bright_white = '#fee3cd',
}

local set = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end
local link = function(group, target) set(group, { link = target }) end

-- Editor UI
set('Normal', { fg = colors.foreground, bg = colors.background })
set('NormalNC', { fg = colors.foreground, bg = colors.background })
set('NormalFloat', { fg = colors.foreground, bg = colors.black })
set('FloatBorder', { fg = colors.bright_green, bg = colors.black })
set('FloatTitle', { fg = colors.bright_yellow, bg = colors.black, bold = true })
set('Cursor', { fg = colors.background, bg = colors.cursor })
set('lCursor', { fg = colors.background, bg = colors.cursor })
set('CursorLine', { bg = colors.black })
set('CursorColumn', { bg = colors.black })
set('ColorColumn', { bg = colors.black })
set('Visual', { bg = colors.selection })
set('VisualNOS', { bg = colors.selection })
set('Search', { fg = colors.background, bg = colors.bright_yellow })
set('IncSearch', { fg = colors.background, bg = colors.bright_blue })
link('CurSearch', 'IncSearch')
set('Substitute', { fg = colors.background, bg = colors.magenta })
set('LineNr', { fg = colors.bright_black, bg = colors.background })
set('LineNrAbove', { fg = colors.bright_black, bg = colors.background })
set('LineNrBelow', { fg = colors.bright_black, bg = colors.background })
set('CursorLineNr', { fg = colors.cursor, bg = colors.black, bold = true })
set('SignColumn', { fg = colors.bright_green, bg = colors.background })
set('FoldColumn', { fg = colors.bright_green, bg = colors.background })
set('Folded', { fg = colors.bright_green, bg = colors.black })
set('WinSeparator', { fg = colors.bright_black, bg = colors.background })
set('StatusLine', { fg = colors.bright_white, bg = colors.black, bold = true })
set('StatusLineNC', { fg = colors.bright_green, bg = colors.black })
set('TabLine', { fg = colors.bright_green, bg = colors.black })
set('TabLineFill', { fg = colors.bright_black, bg = colors.background })
set('TabLineSel', { fg = colors.background, bg = colors.cursor, bold = true })
set('WinBar', { fg = colors.bright_yellow, bg = colors.background })
set('WinBarNC', { fg = colors.bright_green, bg = colors.background })
set('Pmenu', { fg = colors.foreground, bg = colors.black })
set('PmenuSel', { fg = colors.bright_white, bg = colors.selection, bold = true })
set('PmenuSbar', { bg = colors.blue })
set('PmenuThumb', { bg = colors.bright_green })
set('WildMenu', { fg = colors.background, bg = colors.cursor })
set('MatchParen', { fg = colors.bright_blue, bold = true, underline = true })
set('NonText', { fg = colors.bright_black })
set('Whitespace', { fg = colors.bright_black })
set('SpecialKey', { fg = colors.bright_green })
set('EndOfBuffer', { fg = colors.background })
set('Directory', { fg = colors.bright_blue, bold = true })
set('Title', { fg = colors.bright_yellow, bold = true })
set('Question', { fg = colors.bright_cyan })
set('MoreMsg', { fg = colors.bright_cyan })
set('ModeMsg', { fg = colors.bright_blue, bold = true })
set('WarningMsg', { fg = colors.bright_yellow })
set('ErrorMsg', { fg = colors.bright_red, bold = true })

-- Vim syntax, following Pi's syntax roles.
set('Comment', { fg = colors.bright_green })
set('Constant', { fg = colors.bright_red })
set('String', { fg = colors.bright_cyan })
link('Character', 'String')
set('Number', { fg = colors.bright_red })
link('Boolean', 'Number')
link('Float', 'Number')
set('Identifier', { fg = colors.foreground })
set('Function', { fg = colors.bright_yellow })
set('Statement', { fg = colors.bright_blue })
link('Conditional', 'Statement')
link('Repeat', 'Statement')
link('Label', 'Statement')
link('Keyword', 'Statement')
link('Exception', 'Statement')
set('Operator', { fg = colors.cyan })
set('PreProc', { fg = colors.magenta })
link('Include', 'PreProc')
link('Define', 'PreProc')
link('Macro', 'PreProc')
link('PreCondit', 'PreProc')
set('Type', { fg = colors.magenta })
link('StorageClass', 'Type')
link('Structure', 'Type')
link('Typedef', 'Type')
set('Special', { fg = colors.cyan })
link('SpecialChar', 'Special')
link('Tag', 'Special')
link('Delimiter', 'Comment')
link('SpecialComment', 'Comment')
set('Underlined', { fg = colors.bright_blue, underline = true })
set('Todo', { fg = colors.background, bg = colors.bright_yellow, bold = true })
set('Error', { fg = colors.bright_red, bold = true })

-- Treesitter semantic groups.
link('@comment', 'Comment')
link('@string', 'String')
link('@string.escape', 'SpecialChar')
link('@character', 'Character')
link('@number', 'Number')
link('@number.float', 'Float')
link('@boolean', 'Boolean')
link('@variable', 'Identifier')
link('@variable.builtin', 'Special')
link('@variable.parameter', 'Identifier')
link('@constant', 'Constant')
link('@constant.builtin', 'Special')
link('@function', 'Function')
link('@function.call', 'Function')
link('@function.builtin', 'Special')
link('@function.method', 'Function')
link('@constructor', 'Function')
link('@keyword', 'Keyword')
link('@keyword.function', 'Keyword')
link('@keyword.operator', 'Operator')
link('@operator', 'Operator')
link('@type', 'Type')
link('@type.builtin', 'Type')
link('@property', 'Identifier')
link('@attribute', 'PreProc')
link('@punctuation', 'Comment')
link('@punctuation.bracket', 'Comment')
link('@punctuation.delimiter', 'Comment')
link('@tag', 'Tag')
link('@tag.attribute', 'Identifier')
link('@markup.heading', 'Title')
link('@markup.link', 'Underlined')
link('@markup.raw', 'String')
link('@markup.list', 'Special')

-- LSP semantic tokens defer to the matching Treesitter groups.
link('@lsp.type.variable', '@variable')
link('@lsp.type.parameter', '@variable.parameter')
link('@lsp.type.property', '@property')
link('@lsp.type.function', '@function')
link('@lsp.type.method', '@function.method')
link('@lsp.type.class', '@type')
link('@lsp.type.interface', '@type')
link('@lsp.type.enum', '@type')
link('@lsp.type.keyword', '@keyword')
link('@lsp.type.comment', '@comment')
link('@lsp.type.string', '@string')
link('@lsp.type.number', '@number')

-- Diagnostics
set('DiagnosticError', { fg = colors.bright_red })
set('DiagnosticWarn', { fg = colors.bright_yellow })
set('DiagnosticInfo', { fg = colors.bright_blue })
set('DiagnosticHint', { fg = colors.bright_cyan })
set('DiagnosticOk', { fg = colors.bright_cyan })
set('DiagnosticUnderlineError', { undercurl = true, sp = colors.bright_red })
set('DiagnosticUnderlineWarn', { undercurl = true, sp = colors.bright_yellow })
set('DiagnosticUnderlineInfo', { undercurl = true, sp = colors.bright_blue })
set('DiagnosticUnderlineHint', { undercurl = true, sp = colors.bright_cyan })

-- Diffs and GitSigns, matching Pi's diff colors.
set('DiffAdd', { fg = colors.bright_cyan, bg = colors.black })
set('DiffDelete', { fg = colors.bright_red, bg = colors.background })
set('DiffChange', { fg = colors.foreground, bg = colors.blue })
set('DiffText', { fg = colors.bright_white, bg = colors.selection, bold = true })
set('GitSignsAdd', { fg = colors.bright_cyan })
set('GitSignsChange', { fg = colors.bright_yellow })
set('GitSignsDelete', { fg = colors.bright_red })

-- Plugin UI
set('TelescopeBorder', { fg = colors.bright_green, bg = colors.background })
set('TelescopePromptBorder', { fg = colors.bright_blue, bg = colors.black })
set('TelescopePromptNormal', { fg = colors.foreground, bg = colors.black })
set('TelescopePromptPrefix', { fg = colors.cursor, bg = colors.black })
set('TelescopeSelection', { fg = colors.bright_white, bg = colors.selection, bold = true })
set('TelescopeMatching', { fg = colors.bright_blue, bold = true })
set('WhichKey', { fg = colors.bright_blue })
set('WhichKeyGroup', { fg = colors.magenta })
set('WhichKeyDesc', { fg = colors.foreground })
set('WhichKeySeparator', { fg = colors.bright_black })
set('WhichKeyFloat', { bg = colors.black })
set('BlinkCmpMenu', { fg = colors.foreground, bg = colors.black })
set('BlinkCmpMenuSelection', { fg = colors.bright_white, bg = colors.selection })
set('BlinkCmpLabelMatch', { fg = colors.bright_blue, bold = true })
set('BlinkCmpKind', { fg = colors.magenta })
set('MiniStatuslineModeNormal', { fg = colors.background, bg = colors.bright_blue, bold = true })
set('MiniStatuslineModeInsert', { fg = colors.background, bg = colors.bright_cyan, bold = true })
set('MiniStatuslineModeVisual', { fg = colors.background, bg = colors.magenta, bold = true })
set('MiniStatuslineModeReplace', { fg = colors.background, bg = colors.bright_red, bold = true })
set('MiniStatuslineModeCommand', { fg = colors.background, bg = colors.cursor, bold = true })
set('MiniStatuslineDevinfo', { fg = colors.foreground, bg = colors.blue })
set('MiniStatuslineFilename', { fg = colors.foreground, bg = colors.black })
set('MiniStatuslineFileinfo', { fg = colors.foreground, bg = colors.blue })
set('TodoBgTODO', { fg = colors.background, bg = colors.bright_blue, bold = true })
set('TodoBgFIX', { fg = colors.background, bg = colors.bright_red, bold = true })
set('TodoBgWARN', { fg = colors.background, bg = colors.bright_yellow, bold = true })
set('TodoBgNOTE', { fg = colors.background, bg = colors.magenta, bold = true })
set('LazyButtonActive', { fg = colors.background, bg = colors.cursor, bold = true })
set('LazyH1', { fg = colors.background, bg = colors.bright_blue, bold = true })
set('MasonHeader', { fg = colors.background, bg = colors.bright_blue, bold = true })
set('MasonHighlight', { fg = colors.bright_blue })
set('FidgetTitle', { fg = colors.bright_yellow })
set('FidgetTask', { fg = colors.bright_green })

-- Terminal ANSI palette.
vim.g.terminal_color_0 = colors.black
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_5 = colors.magenta
vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_7 = colors.white
vim.g.terminal_color_8 = colors.bright_black
vim.g.terminal_color_9 = colors.bright_red
vim.g.terminal_color_10 = colors.bright_green
vim.g.terminal_color_11 = colors.bright_yellow
vim.g.terminal_color_12 = colors.bright_blue
vim.g.terminal_color_13 = colors.bright_magenta
vim.g.terminal_color_14 = colors.bright_cyan
vim.g.terminal_color_15 = colors.bright_white
