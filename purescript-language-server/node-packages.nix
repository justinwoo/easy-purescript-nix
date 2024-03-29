# This file has been generated by node2nix 1.11.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? []}:

let
  sources = {
    "isexe-2.0.0" = {
      name = "isexe";
      packageName = "isexe";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz";
        sha512 = "RHxMLp9lnKHGHRng9QFhRCMbYAcVpn69smSGcq3f36xjgVVWThj4qqLbTLlq7Ssj8B+fIQ1EuCEGI2lKsyQeIw==";
      };
    };
    "shell-quote-1.8.1" = {
      name = "shell-quote";
      packageName = "shell-quote";
      version = "1.8.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/shell-quote/-/shell-quote-1.8.1.tgz";
        sha512 = "6j1W9l1iAs/4xYBI1SYOVZyFcCis9b4KCLQ8fgAGG07QvzaRLVVRQvAy85yNmmZSjYjg4MWh4gNvlPujU/5LpA==";
      };
    };
    "uuid-9.0.1" = {
      name = "uuid";
      packageName = "uuid";
      version = "9.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/uuid/-/uuid-9.0.1.tgz";
        sha512 = "b+1eJOlsR9K8HJpow9Ok3fiWOWSIcIzXodvv0rQjVoOVNpWMpxf1wZNpt4y9h10odCNrqnYp1OBzRktckBe3sA==";
      };
    };
    "vscode-jsonrpc-8.1.0" = {
      name = "vscode-jsonrpc";
      packageName = "vscode-jsonrpc";
      version = "8.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-jsonrpc/-/vscode-jsonrpc-8.1.0.tgz";
        sha512 = "6TDy/abTQk+zDGYazgbIPc+4JoXdwC8NHU9Pbn4UJP1fehUyZmM4RHp5IthX7A6L5KS30PRui+j+tbbMMMafdw==";
      };
    };
    "vscode-jsonrpc-8.2.0" = {
      name = "vscode-jsonrpc";
      packageName = "vscode-jsonrpc";
      version = "8.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-jsonrpc/-/vscode-jsonrpc-8.2.0.tgz";
        sha512 = "C+r0eKJUIfiDIfwJhria30+TYWPtuHJXHtI7J0YlOmKAo7ogxP20T0zxB7HZQIFhIyvoBPwWskjxrvAtfjyZfA==";
      };
    };
    "vscode-languageserver-8.1.0" = {
      name = "vscode-languageserver";
      packageName = "vscode-languageserver";
      version = "8.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver/-/vscode-languageserver-8.1.0.tgz";
        sha512 = "eUt8f1z2N2IEUDBsKaNapkz7jl5QpskN2Y0G01T/ItMxBxw1fJwvtySGB9QMecatne8jFIWJGWI61dWjyTLQsw==";
      };
    };
    "vscode-languageserver-protocol-3.17.3" = {
      name = "vscode-languageserver-protocol";
      packageName = "vscode-languageserver-protocol";
      version = "3.17.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-protocol/-/vscode-languageserver-protocol-3.17.3.tgz";
        sha512 = "924/h0AqsMtA5yK22GgMtCYiMdCOtWTSGgUOkgEDX+wk2b0x4sAfLiO4NxBxqbiVtz7K7/1/RgVrVI0NClZwqA==";
      };
    };
    "vscode-languageserver-textdocument-1.0.11" = {
      name = "vscode-languageserver-textdocument";
      packageName = "vscode-languageserver-textdocument";
      version = "1.0.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-textdocument/-/vscode-languageserver-textdocument-1.0.11.tgz";
        sha512 = "X+8T3GoiwTVlJbicx/sIAF+yuJAqz8VvwJyoMVhwEMoEKE/fkDmrqUgDMyBECcM2A2frVZIUj5HI/ErRXCfOeA==";
      };
    };
    "vscode-languageserver-types-3.17.3" = {
      name = "vscode-languageserver-types";
      packageName = "vscode-languageserver-types";
      version = "3.17.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-types/-/vscode-languageserver-types-3.17.3.tgz";
        sha512 = "SYU4z1dL0PyIMd4Vj8YOqFvHu7Hz/enbWtpfnVbJHU4Nd1YNYx8u0ennumc6h48GQNeOLxmwySmnADouT/AuZA==";
      };
    };
    "vscode-uri-2.1.2" = {
      name = "vscode-uri";
      packageName = "vscode-uri";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-uri/-/vscode-uri-2.1.2.tgz";
        sha512 = "8TEXQxlldWAuIODdukIb+TR5s+9Ds40eSJrw+1iDDA9IFORPjMELarNQE3myz5XIkWWpdprmJjm1/SxMlWOC8A==";
      };
    };
    "which-2.0.2" = {
      name = "which";
      packageName = "which";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/which/-/which-2.0.2.tgz";
        sha512 = "BLI3Tl1TW3Pvl70l3yq3Y64i+awpwXqsGBYWkkqMtnbXgrMD+yj7rhW0kuEDxzJaYXGjEW5ogapKNMEKNMjibA==";
      };
    };
  };
in
{
  purescript-language-server = nodeEnv.buildNodePackage {
    name = "purescript-language-server";
    packageName = "purescript-language-server";
    version = "0.17.2";
    src = fetchurl {
      url = "https://registry.npmjs.org/purescript-language-server/-/purescript-language-server-0.17.2.tgz";
      sha512 = "HGl62LzelDrfJBmtuUdxAFuEbvt/geEtL/Bzpl/vpJitmYXfbDgOf245wn8rX6h4YgC2AzfVt4wWW+5aNGIsuw==";
    };
    dependencies = [
      sources."isexe-2.0.0"
      sources."shell-quote-1.8.1"
      sources."uuid-9.0.1"
      sources."vscode-jsonrpc-8.2.0"
      sources."vscode-languageserver-8.1.0"
      (sources."vscode-languageserver-protocol-3.17.3" // {
        dependencies = [
          sources."vscode-jsonrpc-8.1.0"
        ];
      })
      sources."vscode-languageserver-textdocument-1.0.11"
      sources."vscode-languageserver-types-3.17.3"
      sources."vscode-uri-2.1.2"
      sources."which-2.0.2"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Language Server Protocol server for PureScript wrapping purs ide server functionality";
      homepage = "https://github.com/nwolverson/purescript-language-server";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
