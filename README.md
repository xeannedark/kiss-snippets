# Keep It Stupid Simple Snippets!

The snippets plugin that does so little, you might as well just write the snippets directly!

## Why?

Because other plugins are too featureful and in some cases even slow.

## How?

1) Add KISS Snippets (or kissnips) using your favorite plugin manager, for `vim-plug` it will look like this:

	`call plug#begin()
	Plug xeannedark/kiss-snippets
	call plug#end()`

2) Add this line to your .vimrc/init.vim:

`:nnoremap <foo> KISSnippets`

Replace <foo> with your preferred keymapping, such as <C-s> for "Ctrl-s".

3) Get some snippets!

Using this format

`snippet nameofsnippet
	snippet content
endsnippet`

Add some snippets to a ".snippets" file, save them, open any document with vim/nvim and in normal mode hit your keymapping, hit tab and enjoy fuzzy completion!

## What about insert mode?

Insert mode completion in vim/nvim is different from the "input()" function completion which is what this plugin uses, for the sake of simplicity (and lack of capability) KISS Snippets can only be used in insert mode through a keymapping such as:

`:inoremap <foo> <Esc>KiSSnippets<Enter>`

And manually switching to insert mode again. It's not elegant, but it's also the first version and everyone is welcome to contribute!

# TL;DR pls

KISS Snippets is a plugin that enables the usage of user-defined snippets with fuzzy completion trhough a single keymapping.

KISS Snippets follows the KISS principle since it's comprised entirely by:

* 1 variable check at the beginning
* 6 functions
* 1 command

Due to the code base being a grand total of 140 lines comments included, anyone with enough time to read the `:help` pages can extend and personalize KISS Snippets!


