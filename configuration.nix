# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

# Use the systemd-boot EFI boot loader.
#boot.loader.systemd-boot.enable = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/nvme0n1p1"
    boot.loader.grub.useOSProber = true;

    networking.hostName = "Nixos"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
        networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
        time.timeZone = "America/NewYork";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalization properties
i18n.defaultLocaleSettings = "en_US.UTF-8";

i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
};

# Enable the X11 windowing system.
    services.xserver = {
        layout = "us";
        xkbVariant = "";
        enable = true;
        displayManager.sddm = {
            enable = true;
        };
    };

# Enable the hyprland Desktop Environment
    programs.hyprland = {
        enable = true;
        xwayland = {
            enable = true;
        };
    };

# Allow Unfree packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowInsecure = true;


# Configure keymap in X11

# services.xserver.layout = "us";
# services.xserver.xkbOptions = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
    services.printing = {
        enable = true;
        drivers = [ pkgs.epson-escpr ];
        browsing = true;
        defaultShared = true;
    };
# Enable sound.
    sound.enable = true;
# hardware.pulseaudio.enable = true;
# hardware.bluetooth.enable = true;
    hardware = {
    #    pulseaudio.enable = true;
        bluetooth.enable = true;
    };
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
    };

# Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

# Enable Virtualization
    boot.extraModprobeConfig = "options kvm_intel nested=1";

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.edipratech = {
        isNormalUser = true;
        description = "Daniel Arpide";
        extraGroups = [ "networkmanager" "wheel" "video" "kvm" ]; # Enable ‘sudo’ for the user.
            packages = with pkgs; [
            ];
    };

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
            brightnessctl
            cargo
            cmake
            firefox
            fzf
            gcc
            gimp
            git
            glibc
            go
            gnome.gnome-font-viewer
            gparted
            gtk3
            hyprland
            libreoffice
            libsecret
            libvirt
            lsd
            lxappearance
            meson
            fastfetch 
            ninja
            networkmanagerapplet
	    neovim
            parsec-bin
            pipewire
            polkit_gnome
            qemu_kvm
	    rofi
            rustup
            sddm
	    terminator
            tldr
            unzip
            virt-manager
            waybar
            wget
            wireplumber
            wofi
            xwayland
            ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
 programs.gnupg.agent = {
   enable = true;
   enableSSHSupport = true;
 };

# Enable the OpenSSH daemon.
 services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It's perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}

