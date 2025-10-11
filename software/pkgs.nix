{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    signal-desktop-bin
    corectrl
    wget
    vscode
    git
    rar
    via
    discord
    libreoffice
    hunspell
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
