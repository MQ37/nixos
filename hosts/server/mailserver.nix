{ config, pkgs, ... }: {

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
