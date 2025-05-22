{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    signal-desktop-bin
    corectrl
    wget
    vscode
    git
    rar
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
