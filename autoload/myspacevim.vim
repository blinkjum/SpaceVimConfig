

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

" -----------------------------------------------------------
" ----------------------Leaderf设置--------------------------
" -----------------------------------------------------------
  "示例：添加一个以 SPC 为前缀的快捷键
  "call SpaceVim#custom#SPCGroupName(['G'], '+TestGroup')
  "ccall SpaceVim#custom#SPC('nore', ['G', 't'], 'echom 1', 'echomessage 1', 1)
  call SpaceVim#custom#SPC('nore', [ 'f',  'f'], 'Leaderf file', 'search file in prj', 1)
  call SpaceVim#custom#SPC('nore', [ 'f',  'w'], 'LeaderfLineAll', 'search word in prj', 1)

" -----------------------------------------------------------
" ---------------------easymotion设置------------------------
" -----------------------------------------------------------
  "easymotion 特殊映射，其他不变
  map E <Plug>(easymotion-e)
  map B <Plug>(easymotion-b)
" -----------------------------------------------------------
" ---------------------CtrlsF设置----------------------------
" -----------------------------------------------------------
  "ctrlsf设置 使用rg(ripgrep)搜索
  let g:ctrlsf_ackprg = 'rg'
  "搜索结果（正常模式和紧凑模式）都不自动关闭
  let g:ctrlsf_auto_close = {
              \ "normal" : 0,
              \ "compact": 0
              \}
  "大小写不敏感
  let g:ctrlsf_case_sensitive='no'
  "搜索路径为当前工程
  let g:ctrlsf_default_root='project' 
  "光标自动聚焦到搜索结果窗口
  let g:ctrlsf_auto_focus = {
              \ "at": "done",
              \ "duration_less_than": 1500
              \ }
  "自定义搜索结果上下文显示行数
  " let g:ctrlsf_context = '-B 5 -A 3'
  "默认搜索结果窗口为紧凑模式
  " let g:ctrlsf_default_view_mode = 'compact'
  "使用 Ctrl + f 查找当前光标下的单词
  nmap <C-F> <Plug>CtrlSFCwordPath

" -----------------------------------------------------------
" ---------------------cscope设置----------------------------
" -----------------------------------------------------------
  "cscope 映射
  " map  ts :cscope find s  <c-r>=expand('<cword>')<cr><cr>
  " map  tg :cscope find g  <c-r>=expand('<cword>')<cr><cr>
  " map  tc :cscope find c  <c-r>=expand('<cword>')<cr><cr>
  " map  tt :cscope find t  <c-r>=expand('<cword>')<cr><cr>
  " map  te :cscope find e  <c-r>=expand('<cword>')<cr><cr>
  " map  tf :cscope find f  <c-r>=expand('<cfile>')<cr><cr>
  " map  ti :cscope find i ^<c-r>=expand('<cfile>')<cr>$<cr>
  " map  td :cscope find d  <c-r>=expand('<cword>')<cr><cr>

" -----------------------------------------------------------
" ---------------------ctags设置----------------------------
" -----------------------------------------------------------
  "更新tags
  map tt :!ctags -R *<cr><cr>
  "更新tag着色文件
  map tup :UpdateTypesFile<cr>


" -----------------------------------------------------------
" ------------------------end--------------------------------
" -----------------------------------------------------------
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

  "移动到本行最尾  
  nmap - $

  "映射#到gd
  map gd #

  "分割窗口并在新窗口中传向定义
  map gl :call MyMarkWord()<cr>gd:call MySetPos()<cr>
  "分割窗口并在当前窗口中传向定义
  map gk :call MyMarkWordCur()<cr>

  "修改S为把当前词替换成之前复制的内容
  map S viw"0p
  "系统复制粘贴
  map <unique> <leader>y "*y
  map <unique> <leader>p "*p
  map <unique> <leader>P "*P
endfunction
