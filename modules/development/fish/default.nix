{ config, pkgs, ... }:

let
  oh-my-fish = {
    name = "foreign-env";
    src = pkgs.fetchFromGitHub {
      owner = "oh-my-fish";
      repo = "plugin-foreign-env";
      rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
      sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
    };
  };
  fzf-fish = {
    name = "fzf.fish";
    src = pkgs.fetchFromGitHub {
      owner = "PatrickF1";
      repo = "fzf.fish";
      rev = "6d8e962f3ed84e42583cec1ec4861d4f0e6c4eb3";
      hash = "sha256-0rnd8oJzLw8x/U7OLqoOMQpK81gRc7DTxZRSHxN9YlM=";
    };
  };
  fish-exa-after-cd = {
    name = "fish-exa-after-cd";
    src = pkgs.fetchFromGitHub {
      owner = "diegodox";
      repo = "fish-exa-after-cd";
      rev = "cafee5e271323a9b3a861c6a293b78abec6c2235";
      hash = "sha256-QGzOQM5XJ/Bqml5pHraRlTUmXS+u7Bh9UAiOxK3qcuU=";
    };
  };
in
{
  config.programs.fish = {
    enable = true;
    plugins = [
      oh-my-fish
      fzf-fish
      fish-exa-after-cd
    ];

    shellAbbrs = {
      r = "ranger";
      lg = "lazygit";
    };

    functions = {
      fish_prompt = {
        description = "prompt";
        body = builtins.readFile ./functions/fish_prompt.fish;
      };
    };
  };

  config.programs.fzf = { enable = true; };
}
