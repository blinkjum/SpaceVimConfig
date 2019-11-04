

function! MySavePos()
  let g:g_save_cursor = getpos(".")
endfunction

function! MySetPos()
    call setpos('.', g:g_save_cursor)
endfunction

function! MyMarkWord()
  let cword=expand('<cword>')
  call MySavePos()
  let cmd='vertical botright ptag! '.cword.'| vertical res 80|let g:g_gonext_flag="ptn"'
  "echo cmd
  silent exe cmd
endfunction

function! MyMarkWordCur()
    let cword=expand('<cword>')
    let cmd='ta! '.cword.'| let g:g_gonext_flag="tn"'
    "echo cmd
    silent exe cmd
endfunction



"!!!!!!!!!!!!!!!!!!!!!!!!!!启动函数 bootstrap_before 将在读取用户配置后执行。
func! myspacevim#before() abort

  "示例：添加一个以 SPC 为前缀的快捷键
  "call SpaceVim#custom#SPCGroupName(['G'], '+TestGroup')
  "ccall SpaceVim#custom#SPC('nore', ['G', 't'], 'echom 1', 'echomessage 1', 1)
  call SpaceVim#custom#SPC('nore', [ 'f',  'f'], 'Leaderf file', 'search file in prj', 1)
  call SpaceVim#custom#SPC('nore', [ 'f',  'w'], 'LeaderfLineAll', 'search word in prj', 1)

endf

"!!!!!!!!!!!!!!!!!!!!!!!!!启动函数 bootstrap_after 将在 VimEnter autocmd 之后执行
function! myspacevim#after() abort

  "tagbar快速显示
  map tl <F2>

  " my widnows
  nmap wj <C-W>j
  nmap wl <C-W>l
  nmap wk <C-W>k
  nmap wh <C-W>h
  nmap wv <C-W>v
  nmap wc <C-W>c
  nmap wp :sp<cr>
  nmap ws :vertical res 50<cr>
  nmap w2 :vertical res 20<cr>
  nmap w3 :vertical res 30<cr>
  nmap wm :vertical res 100<cr> 

  "快速翻页
  nnoremap J <C-F>
  nnoremap K <C-B>

  "禁用neomake语法检测
  call neomake#configure#disable_automake()

  "移动到本行最尾  
  nmap - $

  "更新tags
  map tt :!ctags -R<cr><cr>

  "分割窗口并在新窗口中传向定义
  map gl :call MyMarkWord()<cr>gd:call MySetPos()<cr>
  "分割窗口并在当前窗口中传向定义
  map gk :call MyMarkWordCur()<cr>

  "系统复制粘贴
  map <unique> <leader>y "*y
  map <unique> <leader>p "*p
  map <unique> <leader>P "*P

endfunction
