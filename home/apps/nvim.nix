{ pkgs, lib, config, ... }:

{
  programs.neovim = {
    enable = true;

    # lsp and tools servers available on $PATH for neovim
    extraPackages = with pkgs; [
      # general depedencies
      git
      lazygit
      ripgrep
      fzf
      fd
      tree-sitter

      # Language servers
      # LUA
      lua-language-server
      stylua

      # NIX
      nil
      nixfmt
      statix

      clang-tools
      phpactor
      gcc
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages."@tailwindcss/language-server"
    ];

    # Only lazy-nvim itself is loaded as a Neovim plugin
    plugins = with pkgs.vimPlugins; [ lazy-nvim ];

    extraLuaConfig =
      # lua
      let
        treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;

        treesitterGrammars = pkgs.symlinkJoin {
          name = "nvim-treesitter-grammars";
          paths = treesitter.dependencies;
        };

        # Plugins
        plugins = with pkgs.vimPlugins; [
	  lazy-nvim
	  {
	    name = "telescope.nvim";
	    path = telescope-nvim;
	  }
	  plenary-nvim

	  # Core
	  plenary-nvim

	  # UI
	  lualine-nvim
	  bufferline-nvim
	  which-key-nvim

	  # LSP / completion
	  nvim-lspconfig
	  {
            name = "blink.cmp";
	    path = blink-cmp;
	  }
	  
	  # Treesitter
	  nvim-treesitter

	  # File explorer
	  neo-tree-nvim
	  nui-nvim

	  # Git
	  gitsigns-nvim

	  alpha-nvim
	  
	  {
	    name = "mini.pairs";
	    path = mini-pairs;
	  }
	  indent-blankline-nvim


          # When a plugin's name in nixpkgs doesn't match what Lazy expects,
          # you can manually specify the mapping like this:
          {
            name = "catppuccin";
            path = catppuccin-nvim;
          }
        ];

        # Maps a plugin derivation to a { name, path } pair.
        # linkFarm expects this format to create a directory of symlinks
        # where each plugin is accessible by its name.
        mkEntryFromDrv =
          drv:
          if lib.isDerivation drv then
            {
              name = "${lib.getName drv}";
              path = drv;
            }
          else
            drv;

        # Creates a directory with symlinks to all plugins, keyed by name.
        # This is what Lazy uses as its local plugin source via dev.path.
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);

      in
      # lua
      ''
	-- bootstrap lazy
	require("lazy").setup({
	  dev = {
	    path = "${lazyPath}",
	    patterns = { "." },
	    fallback = false,
	  },

	  spec = {
	    -- UI / core
	    { "nvim-lualine/lualine.nvim", config = true },
	    { "akinsho/bufferline.nvim", config = true },
	    { "folke/which-key.nvim", config = true },

	    -- LSP
	    { "neovim/nvim-lspconfig" },

	    -- Completion
	    { 
	      "saghen/blink.cmp", 
	      config = function()
	      	require("blink.cmp").setup({
		  keymap = {
		    preset = "default",

		    ["<Tab>"] = { "select_next", "fallback" },
		    ["<S-Tab>"] = { "select_prev", "fallback" },
		    ["<CR>"] = { "accept", "fallback" },
		  },
		})
	       end,
	    },

	    -- Treesitter (Nix-managed)
	    {
	      "nvim-treesitter/nvim-treesitter",
	      build = false,
	      config = function()
		require("nvim-treesitter.configs").setup({
		  highlight = { enable = true },
		})
	      end,
	    },

	    -- guide line
	    {
	      "lukas-reineke/indent-blankline.nvim",
	  	config = function()
	    	  require("ibl").setup({
	      	  indent = {
		    char = "│",  -- vertical line
	      	  },
	          scope = {
		    enabled = true,  -- highlight current block
	          },
	        })
	      end,
	    },

	    -- Telescope
	    {
	      "nvim-telescope/telescope.nvim",
	      config = function()
	    	local telescope = require("telescope")

	    	telescope.setup({
	      	  defaults = {
		    layout_config = {
		      prompt_position = "top",
		    },
		    sorting_strategy = "ascending",
	          },
	        })

	        -- load fzf extension (if installed)
	    	pcall(telescope.load_extension, "fzf")
	     end,
	    },

	    -- Dashboard
	    {
	      "goolord/alpha-nvim",
	      config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
		  "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
		  "████╗  ██║██║   ██║██║████╗ ████║",
		  "██╔██╗ ██║██║   ██║██║██╔████╔██║",
		  "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
		  "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
		  "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
		}

	    	dashboard.section.buttons.val = {
	      	  dashboard.button("e", "  New file", ":ene <CR>"),
	      	  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
	      	  dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
	      	  dashboard.button("q", "  Quit", ":qa<CR>"),
	    	}

	    	alpha.setup(dashboard.opts)
	       end,
	     },

	    -- mini pairs
	    { "echasnovski/mini.pairs", config = true },

	    -- Git
	    { "lewis6991/gitsigns.nvim", config = true },

	    -- File explorer
	    { "nvim-neo-tree/neo-tree.nvim", config = true },

	    -- Utils
	    { "nvim-lua/plenary.nvim" },
	  },
	})

	-- line number
	vim.opt.number = true
	vim.opt.relativenumber = true

	-- tab space 
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.expandtab = true

	-- colorscheme
	vim.cmd("colorscheme habamax")

	-- =====================
	-- LSP (Neovim 0.11 way)
	-- =====================

	vim.lsp.config("clangd", {})
	vim.lsp.enable("clangd")

	vim.lsp.config("phpactor", {})
	vim.lsp.enable("phpactor")

	vim.lsp.config("tsserver", {})
	vim.lsp.enable("tsserver")

	vim.lsp.config("html", {})
	vim.lsp.enable("html")

	vim.lsp.config("cssls", {})
	vim.lsp.enable("cssls")

	vim.lsp.config("jsonls", {})
	vim.lsp.enable("jsonls")

	-- =====================
	-- Basic keymaps
	-- =====================

	vim.keymap.set("n", "gd", vim.lsp.buf.definition)
	vim.keymap.set("n", "K", vim.lsp.buf.hover)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      '';
  };
  # Normal LazyVim config here, like this: https://github.com/LazyVim/starter/tree/main/lua
  # mkOutOfStoreSymlink is used instead of a regular source so the files
  # aren't copied into the Nix store. This keeps them writable, allowing
  # you to edit your Lua config and see changes immediately without rebuilding.
  # TODO: adjust your source directory accordingly
  # xdg.configFile."nvim/lua" = {
  #  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/LazyVim/lua";
  #  recursive = true;
  # };
}

