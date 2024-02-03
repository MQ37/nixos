{ config, pkgs, ... }: {
  imports = [
    (builtins.fetchTarball {
      # Pick a release version you are interested in and set its hash, e.g.
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-23.11/nixos-mailserver-nixos-23.11.tar.gz";
      # To get the sha256 of the nixos-mailserver tarball, we can use the nix-prefetch-url command:
      # release="nixos-23.05"; nix-prefetch-url "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/${release}/nixos-mailserver-${release}.tar.gz" --unpack
      sha256 = "122vm4n3gkvlkqmlskiq749bhwfd0r71v6vcmg1bbyg4998brvx8";
    })
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.kopecky.io";
    domains = [ "kopecky.io" ];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "me@kopecky.io" = {
        hashedPasswordFile = "/home/mq/mailserver/users/me@kopecky.io";
        aliases = [
                    "postmaster@kopecky.io"
                    "kopecky@kopecky.io"
                    "support@kopecky.io"
                    "security@kopecky.io"
                  ];
      };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme-nginx";

    enableImapSsl = true;
    enablePop3Ssl = true;
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "security@kopecky.io";

}
