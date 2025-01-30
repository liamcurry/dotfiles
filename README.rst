======
.files
======

.. image:: http://i.imgur.com/pG0M4ul.jpg
   :target: http://i.imgur.com/pG0M4ul.jpg
   :alt: Screenshot

Various dotfiles in my home directory.

::

    $ pkgi tmux autojump zsh
    $ sudo easy_install pip readline
    $ sudo pip install flake8 virtualenvwrapper ipython py3kwarn
    $ sudo npm install jshint uglify-js stylus

For go development::

    $ go get github.com/golang/lint/golint
    $ go get -u github.com/nsf/gocode
    $ go get code.google.com/p/go.tools/cmd/goimports

Be sure to configure vim with ``--with-features=big`` to enable unicode
characters, and ``--enable-pythoninterp`` for Python support.


if is_installed("biome") then
    local util = require 'lspconfig.util'
    lspconfig.biome.setup {
        on_attach = function(client, bufnr)
            -- Enable formatting on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        async = false,
                        filter = function(c) return c.name == "biome" end,
                    })
                end,
            })
        end,
        -- Custom root directory strategy
        root_dir = util.root_pattern("package.json", "tsconfig.json", ".git", "Cargo.toml"),
        settings = {
            json = {
                format = { enable = true },
            },
        },
    }
end


lspconfig.marksman.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
    root_dir = util.root_pattern(".git")
})


