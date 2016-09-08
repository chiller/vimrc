{
  allowUnfree = true;
  packageOverrides = pkgs_: with pkgs_; {
    my_ = with pkgs; buildEnv {
      name = "my_";
      paths = [
        i3 i3status i3lock dmenu
        chromium 
        vim
        git 
      ];
    };
  };
}
