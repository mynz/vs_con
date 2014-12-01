
:command! VsGetFile :call VsGetFile()
:command! VsPutFile :call VsPutFile()

nnoremap <Leader>vg :VsGetFile<CR>
nnoremap <Leader>vp :VsPutFile<CR>


let s:vs_con_dir = 'C:\vim\plugins\vs_con\plugin'
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
	" echo cmd
	:call system(cmd)
endfunction
