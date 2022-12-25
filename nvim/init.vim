set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug '~/projects/wpilib_vim'
call plug#end()

let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_python_binary_path='/usr/bin/python3'

