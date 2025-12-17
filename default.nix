{
  lib,
  stdenvNoCC,
  scdoc,
  installShellFiles,
}:
stdenvNoCC.mkDerivation {
  pname = "wk-prompt";
  version = "0.2.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./wk-prompt
      ./wk-prompt.1.scd
    ];
  };

  nativeBuildInputs = [scdoc installShellFiles];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 wk-prompt $out/bin/wk-prompt
    scdoc < wk-prompt.1.scd > wk-prompt.1
    installManPage wk-prompt.1
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/3L0C/wk-prompt";
    description = "Shell scripting aide for wk(1)";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    mainProgram = "wk-prompt";
  };
}
