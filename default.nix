{ lib
, config
, ...
}:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.programs.nvchad;
in
{
  options.programs.nvchad = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable NvChad
      '';
    };
    defaultEditor = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Sets NvChad as your default editor
      '';
    };

    customConfig =
      mkOption
        {
          type = types.path;
          example = "./config";
          description = ''
            Folder with chadrc.lua and other custom configuration
          '';
        };
  };

  config = mkIf cfg.enable {
    programs.neovim.enable = true;
    programs.neovim.defaultEditor = mkIf cfg.defaultEditor true;

    home.file.".config/nvim/lua" = {
      source = ./lua;
      recursive = true;
    };

    home.file.".config/nvim/init.lua" = {
      source = ./init.lua;
    };
  };
}