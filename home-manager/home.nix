# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "cenora";
    homeDirectory = "/home/cenora";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  programs.java.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

# sets git username and email
programs.git = {
  enable = true;
  userName = "enzoconti";
  userEmail = "enzo.conti@usp.br";
};

# enables bashrc alterations
programs.bash = {
  enable = true;
  bashrcExtra = "set completion-ignore-case on";
};

# sets environment variables on bashrc
# environment.variables = {
#   JAVA_HOME = ##dynamically looks for java path;
# }

# creates inputrc and adds a line to ignore case sensitivity on terminal
home.file.".inputrc".text = ''
    set completion-ignore-case on
  '';

  # adding a portuguese special caracter
  home.file.".XCompose".text = ''
    include "%L"

    <dead_acute> <C> : "Ç"
    <dead_acute> <c> : "ç"
  '';


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
