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
    shadps4
    bblauncher
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
