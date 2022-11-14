# Documentation for KISS Snippets

## Initial g:kisSnipsDir check

Every time kiss-snippets.vim is loaded, it will check for a global variable: `g:kisSnipsDir`, if it is set in the user's configuration file it remains unchanged, else it will change it to `$HOM/.vim/snippets` for Vim users and `$XDG_CONFIG_HOME/nvim/snippets` for Neovim users.

It tells both programs apart by checking for a predefined vim variable `v:versionlong`, which is present in Vim but not Neovim, at least in version 800.
A better method of checking could be used, so suggestions are welcome.

## KsListSnippetFiles or KsListSF

This function requires no input, it simply reads the snippets directory set by `g:kisSnipsDir` and returns all the snippet file names as a list (or array of strings).
The returned snippet file names do not contain ".snippets".

## KsListSnippetContent or KsListSC

Reads a given snippet file and returns all the content as a list of lines separated by newlines. The given snippet file name must be a string.

## KsSnipNames

Returns all snippet names inside a given snippet file. Said snippet file must be the output of `KsListSC`, i.e a list with `snippet foo` and `endsnipet` encapsulating the snippet content.

## KsExtractSnip

Returns a snippet as a string. It requires the name of a snippet and the file said snippet resides in. The snippet file, again, is the output of `KsListSC`.

## Completion

Completion is handled by the `KsComplete` function, which is used as a completion function for `input()`. Vim/Nvim will pass the content of the command line to `KsComplete` which will check for a '.' and either give the snippet files in `g:kisSnipsDir` or all the snippet names in a file as completion options.

## KsCore

Upon calling, `KsCore` will prompt the user with a '>' in the command line, the user can then type the desired snippet file and snippet in this order separated by a '.' and no whitespaces. Hitting <Tab> will fuzzy complete with snippet files and snippet names. 

To apply a chosen snippet, <Enter> must be pressed.

To exit the prompt, <C-c>(Control c) must be pressed, pressing <Esc> will give an error, fixing this is a TODO.

If <Tab> yields no results, there are no snippet files or snippets to choose from.

## KISSnippets

This is the command which may be mapped to any key the user desires. It simply calls `KsCore`.

## Snippet files structure

A valid snippet file follows the naming structure `foo.snippets`.

A valid snippet follows the structure:

`snippet foo
foo bar
endsnippet`

The name of this snippet is "foo", and its contents are:
"foo bar"

All characters such as tabs, whitespaces, newlines and carriage returns are read and applied verbatim.
