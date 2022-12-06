{ lib
, buildPythonPackage
, fetchPypi
, attrs
, six
, asn1crypto
, python-dateutil
}:

buildPythonPackage rec {
  pname = "cryptoparser";
  version = "0.8.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-kJg8d1PoGIC0feefbJM8oyXcRyMGdg1wWkQUl/nSNCo=";
  };

  propagatedBuildInputs = [
    attrs
    six
    asn1crypto
    python-dateutil
  ];

  pythonImportsCheck = [
    "cryptoparser"
  ];

  meta = with lib; {
    description = "Security protocol parser and generator";
    homepage = "https://gitlab.com/coroner/cryptoparser";
    changelog = "https://gitlab.com/coroner/cryptoparser/-/blob/v${version}/CHANGELOG.md";
    license = licenses.mpl20;
    maintainers = with maintainers; [ kranzes ];
  };
}
