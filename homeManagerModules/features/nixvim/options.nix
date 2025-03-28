{inputs, ...}: {

programs.nixvim = {
    opts = {
      number = true;
      relativenumber = true;
      autoindent = true;
      expandtab = true;
      shiftwidth = 2;
    };
  };
}
