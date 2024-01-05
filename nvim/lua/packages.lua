local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    print("Installed packer!")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'wellle/context.vim'
  use 'chaoren/vim-wordmotion'
  use 'asvetliakov/vim-easymotion'
  use {'junegunn/fzf', run = ":call fzf#install()"}
  use {'junegunn/fzf.vim'}
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  -- setup ufo
  require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
