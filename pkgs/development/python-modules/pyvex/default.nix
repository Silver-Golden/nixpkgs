{ lib
, stdenv
, archinfo
, bitstring
, buildPythonPackage
, cffi
, fetchPypi
, future
, pycparser
, pythonOlder
, setuptools
}:

buildPythonPackage rec {
  pname = "pyvex";
  version = "9.2.26";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-stxFT4oM4qLHXFJ2+kTNVgcjQ77239Gg0rp6T76wVBU=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    archinfo
    bitstring
    cffi
    future
    pycparser
  ];

  postPatch = lib.optionalString stdenv.isDarwin ''
    substituteInPlace vex/Makefile-gcc \
      --replace '/usr/bin/ar' 'ar'
  '';

  setupPyBuildFlags = lib.optionals stdenv.isLinux [
    "--plat-name"
    "linux"
  ];

  preBuild = ''
    export CC=${stdenv.cc.targetPrefix}cc
    substituteInPlace pyvex_c/Makefile \
      --replace 'AR=ar' 'AR=${stdenv.cc.targetPrefix}ar'
  '';

  # No tests are available on PyPI, GitHub release has tests
  # Switch to GitHub release after all angr parts are present
  doCheck = false;

  pythonImportsCheck = [
    "pyvex"
  ];

  meta = with lib; {
    description = "Python interface to libVEX and VEX IR";
    homepage = "https://github.com/angr/pyvex";
    license = with licenses; [ bsd2 gpl3Plus lgpl3Plus ];
    maintainers = with maintainers; [ fab ];
  };
}
