syntax enable
set rnu
set nu
set cursorline
colorscheme desertEx
set nocompatible
set wildmenu
filetype plugin on
set hlsearch

"pesquisa recursiva
set path+=**

" habilitando folding com za
set foldmethod=indent
set foldlevel=0

" tabs corretos para python
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=100
set noexpandtab
set autoindent

"habilitando verificador ortografico
autocmd Filetype text setl spell spl=pt
autocmd BufNewFile,BufRead *.txt spell spl=pt

"statusline sugerido pelo vimbook
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%f\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

"habilitando o uso de tags com ctags
command! MakeTags !ctags -R .
