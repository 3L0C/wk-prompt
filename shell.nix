{
  pkgs ? import <nixpkgs> { },
  wk-prompt,
}:
pkgs.mkShell {
  buildInputs = [ pkgs.bashInteractive ];
  inputsFrom = [ wk-prompt ];
  nativeBuildInputs = with pkgs; [
    shellcheck
    shfmt
    scdoc
  ];

  shellHook = ''
    echo "wk-prompt development environment"
    echo "  shellcheck wk-prompt  - lint"
    echo "  shfmt -d wk-prompt    - check formatting"
    echo "  scdoc < wk-prompt.1.scd > wk-prompt.1  - build man page"
  '';
}
