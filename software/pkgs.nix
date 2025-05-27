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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
