project = struct(
    cf_deployment = struct(
        version = "8.0.0",
        sha256 = "289f6c5a116eef4b16b228d07d55517dc20f76199c1476036fc0ade5a08a3e1b",
    ),
    helm = struct(
        version = "2.14.1",
        platforms = [
            {
                "platform": "darwin",
                "sha256": "392ec847ecc5870a48a39cb0b8d13c8aa72aaf4365e0315c4d7a2553019a451c",
            },
            {
                "platform": "linux",
                "sha256": "804f745e6884435ef1343f4de8940f9db64f935cd9a55ad3d9153d064b7f5896",
            },
            {
                "platform": "windows",
                "sha256": "604780d3fabeb27e7ab7a30c6e29ce64bcd2203501ea35e5231c97965b0255a0",
            },
        ],
    ),
    kubernetes = struct(
        version = "1.13.8",
        platforms = [
            {
                "platform": "darwin",
                "sha256": "7b788747a5536f5156b37c71489b8a5c18bd6ab8315db84d579e47db1eb9d56a",
            },
            {
                "platform": "linux",
                "sha256": "28919b49b8d9d9aee98001556952cf7d36aae6d4875f4f305399590ff9849d6e",
            },
            {
                "platform": "windows",
                "sha256": "a3b2895aa5d5344971e55126f8b33b65f8b7c3b2ef8b07a1e3d80b06037d0549",
            },
        ],
    ),
    minikube = struct(
        version = "1.2.0",
        platforms = [
            {
                "platform": "darwin",
                "sha256": "183d017d094b7783c938dc709dbdfc9a48f92299178234f89047dfbb083a592c",
            },
            {
                "platform": "linux",
                "sha256": "123fc9f5656333fb2927cf91666a91cd5b28ef97503418ac2a90a2109e518ed9",
            },
            {
                "platform": "windows",
                "sha256": "f6c30cb88ec61bc6fe17532a3ef56e4f1fcef2473e3d73fc56f352b44784490d",
            },
        ],
    ),
    kind = struct(
        version = "0.4.0",
        platforms = [
            {
                "platform": "darwin",
                "sha256": "023f1886207132dcfc62139a86f09488a79210732b00c9ec6431d6f6b7e9d2d3",
            },
            {
                "platform": "linux",
                "sha256": "a97f7d6d97bc0e261ea85433ca564269f117baf0fae051f16b296d2d7541f8dd",
            },
            {
                "platform": "windows",
                "sha256": "58add85c8c1a2d5df7564f814076db5f334b6164098e899bba0c6176d11c9940",
            },
        ],
    ),
    shellcheck = struct(
        platforms = struct(
            darwin = {
                "url": "https://homebrew.bintray.com/bottles/shellcheck-0.6.0_1.mojave.bottle.tar.gz",
                "sha256": "20539e9e7d74ca9f46d397e050343d1bee078c3a47f808682771b2edd9df3ff4",
            },
            linux = {
                "url": "https://storage.googleapis.com/shellcheck/shellcheck-v0.4.7.linux",
                "sha256": "ac6118150d35303382c0a77415386e63a1830f14dce4deda3531292ca55a2dd0",
            },
            windows = {
                "url": "https://storage.googleapis.com/shellcheck/shellcheck-v0.4.7.exe",
                "sha256": "3ac9c5507b8b5febdf7586aa9d8115001696d8a1232b9b740e7ba690b526f9a0",
            },
        ),
    ),
)
