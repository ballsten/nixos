{inputs, ...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      lg = "lazygit";
    };
  };
}
