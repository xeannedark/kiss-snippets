"KISS Snippets' code!
"
"For a more detailed explanation of the functions, read "doc.md".
"
"---

"Set the variable for the snippets directory if the user has not set
"one. It will default to the config directory.

if exists('g:kisSnipsDir')
	let g:kisSnipsDir = g:kisSnipsDir
else
	if exists('v:versionlong')
		let cDir = getenv('HOME')
		let g:kisSnipsDir = cDir."/.vim/snippets"
	else
		let cDir = getenv('XDG_CONFIG_HOME')
		let g:kisSnipsDir = cDir."/nvim/snippets"
	endif
endif

"---

"KsListSnippetFiles retrieves all the .snippets files in the snippets directory and returns them in a list. 

function! KsListSF() abort
	let l:sDir = readdir(g:kisSnipsDir)
	let l:sFList = []
	for sF in l:sDir
		let sF = trim(trim(sF, "snippets", 2), ".")
		call add(sFList, sF)
	endfor
	return l:sFList
endfunction

"---

"KsListSnippetContent retrieves all content from a snippets file and returns it in a list.
"This list is used to extract the names of all snippets and a single snippet.

function! KsListSC(sF) abort
	let l:sFile = g:kisSnipsDir."/".a:sF.".snippets"
	let l:sList = readfile(l:sFile)
	return l:sList
endfunction

"---

"KsSnipNames lists all snippet names in a snippets file, it needs to be fed
"KsListSnippetContent.

function! KsSnipNames(sC) abort
	let l:snips = []
	for s in a:sC
		let sMatch = match( s, "snippet")
		if sMatch == 0
			let sName = trim(trim( s, "snippet", 1), " ")
			call add(l:snips, sName) 
		endif
	endfor
	return l:snips
endfunction

"---

"KsExtractSnip is the function that extracts a snippet and returns it as a string.
"It needs to be fed KsListSC and a snippet name to extract.

function! KsExtractSnip( s, sC) abort
	let l:sFrag = []
	let l:c = 0
	for snip in a:sC
		let s_match = match(snip, "snippet ".a:s)
		let es_match = match(snip, "endsnippet")

		if s_match == 0 && l:c == 0
			let l:c = 1
		elseif es_match == 0 && l:c == 1
			break
		elseif l:c == 1
			call add(sFrag, snip)
		endif
	endfor
	let snippet = join(l:sFrag, "\n")
	return snippet
endfunction

"---

"Completion

"KsComplete is the completion function, it returns either the snippet files 
"or the snippet names in a file as a list. A and C are the characters in the
"command line, and L is the number of the cursor position.

function! KsComplete(A, C, L) abort
	let l:m = match(a:C, "\\.")
	if l:m != -1
		let sF = trim(a:C, ".", 2)
		let sC = KsListSC(sF)
		let n  = KsSnipNames(sC)
		let c = []
		for s in n
			call add(c, sF.".".s)
		endfor
	else
		let c = []
		let aSF = KsListSF()
		for s in l:aSF
			let m = match( s, a:C)
			if m != -1
				call add(c, s)
			endif
		endfor
	endif
	return c
endfunction

"---

"Core function that takes a file and a snippet name and puts the snippet in
"the current line.

function! KsCore() abort
	let i  = input(">", "", "customlist,KsComplete")
	let sF = get(split(i, "\\."), 1)
	let sC = KsListSC(get(split(i,"\\."), 0))
	let @z = KsExtractSnip(sF, sC)
	let cP = getcurpos()
	put z
	call setpos('.',cP)
endfunction

"The KISS Snippets command which will run KsCore, map this to your preferred
"key combination.

command! KISSnippets call KsCore()
