''
      let mapleader = "."

      set number relativenumber		" current number other relative lines
      set showmatch			        " show matchin parentheses
      set ignorecase			    " ignore case
      set hlsearch			        " highlight search
      set incsearch			        " fast search
      set tabstop=4
      set softtabstop=4
      set expandtab			        " tabs to space
      set shiftwidth=4			    " auto indent width
      set autoindent			    " same line indent
      set cc=80				        " 80 chars old school
      syntax on				        " syntax
      set clipboard=unnamedplus		" use system keyboard
      set cursorline			    " cursorline
      set noswapfile			    " no swap files
      set nobackup                  " coc fix
      set nowritebackup             " coc fix

      set updatetime=300            " coc ux
      set signcolumn=yes            " coc ux

      "fzf
      nnoremap <C-p> :GFiles<CR>
      nnoremap <C-l> :Files<CR>

      " nerdtree
      nnoremap <leader>n :NERDTreeFocus<CR>
      nnoremap <C-n> :NERDTree<CR>
      nnoremap <C-t> :NERDTreeToggle<CR>
      nnoremap <C-f> :NERDTreeFind<CR>

      " ultrisnip
      let g:UltiSnipsExpandTrigger="<tab>"
      let g:UltiSnipsJumpForwardTrigger="<c-b>"
      let g:UltiSnipsJumpBackwardTrigger="<c-z>"
''
