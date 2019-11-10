

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
  let g:Lf_PreviewInPopup = 1
  "指定 popup window / floating window 的位置
  let g:Lf_PreviewHorizontalPosition = 'center'
  "指定 popup window / floating window 的宽度。
  let g:Lf_PreviewPopupWidth = 0

  let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
  let g:Lf_WorkingDirectoryMode = 'Ac'
  let g:Lf_WindowHeight = 0.30
  let g:Lf_CacheDirectory = expand('~/.vim/cache')

  " let g:Lf_ShortcutF = '<c-p>'
  noremap <c-n> :LeaderfFunction!<cr>
  " noremap <c-m> :LeaderfRgRecall<cr>
  "全局搜索
  noremap <c-f> :<C-U><C-R>=printf("Leaderf! rg --stayOpen -e %s ", expand("<cword>"))<CR>


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
  " let g:ctrlsf_ackprg = 'rg'
  "搜索结果（正常模式和紧凑模式）都不自动关闭
  " let g:ctrlsf_auto_close = {
              \ "normal" : 0,
              \ "compact": 0
              \}
  "大小写不敏感
  " let g:ctrlsf_case_sensitive='no'
  "搜索路径为当前工程
  " let g:ctrlsf_default_root='project'
  "光标自动聚焦到搜索结果窗口
  " let g:ctrlsf_auto_focus = {
              \ "at": "done",
              \ "duration_less_than": 1500
              \ }
  "自定义搜索结果上下文显示行数
  " let g:ctrlsf_context = '-B 5 -A 3'
  "默认搜索结果窗口为紧凑模式
  " let g:ctrlsf_default_view_mode = 'compact'
  "使用 Ctrl + f 查找当前光标下的单词
  " nmap <C-F> <Plug>CtrlSFCwordPath


" -----------------------------------------------------------
" ---------------------ctags设置----------------------------
" -----------------------------------------------------------
  "更新tags
  map tt :!ctags -R *<cr><cr>
  "更新tag着色文件
  map tup :UpdateTypesFile<cr>

  let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
  let g:gutentags_ctags_tagfile = '.tags'
  let s:vim_tags = expand('~/.vim/cache/tags')
  let g:gutentags_cache_dir = s:vim_tags
  if !isdirectory(s:vim_tags)
      silent! call mkdir(s:vim_tags, 'p')
  endif
  let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']


" -----------------------------------------------------------
" ---------------------ycm设置----------------------------
" -----------------------------------------------------------
"
let g:ycm_confirm_extra_conf = 1
let g:ycm_max_diagnostics_to_display = 0

set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0
" 开启实时错误或者warning的检测
"let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'

let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 补全功能在注释中同样有效
let g:ycm_complete_in_strings=1
" 从第二个键入字符就开始罗列匹配项
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_key_invoke_completion = '<c-z>'
noremap <c-z> <NOP>
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }
"ycm白名单
let g:ycm_filetype_whitelist = { 
            \'c' : 1, 
            \'cpp' : 1, 
            \'python' : 1,
            \'sh':1,
            \}


" -----------------------------------------------------------
" ---------------------Mundo设置----------------------------
" -----------------------------------------------------------
  nnoremap <A-u> :MundoToggle<CR>
  

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
