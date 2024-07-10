{ inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets.yaml;
    # Check all sops files at evaluation time.
    # This requires sops files to be added to the nix store.
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];

      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "p_vpn/il_7/private_key" = {
        path = "/home/kevin/pirating/private_key";
      };
      "test" = { };
    };
  };
}
