{ config, pkgs, ... }:
{
  # Enable WireGuard
  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
     #"wg0" is the network interface name. You can name the interface arbitrarily.
     wgl0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "4.4.4.4/32" ];
      listenPort = 1235; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
      mtu = 1360;
      # Path to the private key file.
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/etc/nixos/private";
      peers = [
        # For a client configuration, one peer entry for the server will suffice.
      {
          # Public key of the server (not a file path).
          publicKey = "444";
          # Forward all the traffic via VPN.
          allowedIPs = [ "4.4.4.4/24" ];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "11.111.11.0/22" ];
          # Set this to the server IP and port.
          name = "hq";
          endpoint = "homebase";  #  ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    }; # it's not imperative but it does not know how to do it : sudo ip route add 11.111.11.111 via 192.168.1.11 dev wlo1 the ip adresse 11: external and 192: local.
  };
}
