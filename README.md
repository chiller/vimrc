# vimrc

##Cheatsheet

F5 relative line numbers
F6 git blame
F7 show recent files
F8 tagbar toggle

<C ]> jump to definition
<C t> go up definition tree



#Vim configuration


1. Vundle Package Manager
  
   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

   Launch vim and run :PluginInstall

2. Monokai color scheme

3. Fzf

https://github.com/junegunn/fzf

from inside vim hit ctrl V to search
from outside do vim **


4. Gitgutter

https://github.com/airblade/vim-gitgutter

5. Ctags
http://andrew.stwrt.ca/posts/vim-ctags/

```
brew install ctags
#inside project folder
ctags -R -f ./.git/tags .
#you will want to reindex this occasionally, maybe on git commit
#inside vim
<C ]> jump to definition
<C t> go back up in stack
:tag function name - jump to definition
:tag /^asserts_*

:TagbarToggle
```


