
:command! VsGetFile :call VsGetFile()
:command! VsPutFile :call VsPutFile()

nnoremap <Leader>vg :VsGetFile<CR>
nnoremap <Leader>vp :VsPutFile<CR>

" http://stackoverflow.com/questions/4976776/how-to-get-path-to-the-current-vimscript-being-executed
let s:vs_con_dir = expand('<sfile>:p:h')
let s:vs_con_rb = s:vs_con_dir . '\vs_con.rb'

function! VsGetFile()
	let cmd = 'ruby ' . s:vs_con_rb . ' --getfile'
	let result = system(cmd)
	let ary = split(result, ',')
	let path = ary[0]
	let row = ary[1]
	let col = ary[2]

	let excmd = ':e +' . row . " " . path
	:execute excmd
endfunction

function! VsPutFile()
	let path = expand("%")
	let line = getpos(".")[1]
	let cmd = 'ruby ' . s:vs_con_rb . ' --putfile ' . path . " " . line
	" echom cmd
	:call system(cmd)
endfunction
