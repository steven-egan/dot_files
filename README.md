```
    ____        __  _____ __
   / __ \____  / /_/ __(_) /__  _____
  / / / / __ \/ __/ /_/ / / _ \/ ___/
 / /_/ / /_/ / /_/ __/ / /  __(__  )
/_____/\____/\__/_/ /_/_/\___/____/
```

!!!
Needed to create a ~/.zprofile that sources ~/.config/zshrc/.zshrc

`brew install luarocks` - Lazy.nvim needs [luarocks](https://luarocks.org/)
`brew install lazygit` - laygit install
`brew install gnupg` - gnupg install
https://www.veracrypt.fr/code/VeraCrypt/
  - brew tap macos-fuse-t/homebrew-cask
  - brew install fuse-t
  - brew install fuse-t-sshfs
Zathura
  - brew tap zegervdv/zathura
  - brew install zathura --with-synctex
  - brew install zathura-pdf-poppler

https://github.com/vimichael/my-nvim-config/blob/main/init.lua
https://github.com/omerxx/dotfiles
https://github.com/Dan7h3x/SciVim/tree/stable/lua/SciVim/plugins

- https://medium.com/@shaikzahid0713/alpha-start-up-screen-8e4a6e95804d
  https://github.com/uiriansan/hyprdots/tree/main/nvim/lua/plugins

https://github.com/mbbill/undotree
https://github.com/nxtkofi/LightningNvim?tab=readme-ov-file#dashboard-images

Getting LSP working
TSX:
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
export PATH="$HOME/.npm-global/bin:$PATH"
npm install -g typescript typescript-language-server



## QMK
qmk compile -kb boardsource/unicorne -km steven-egan 