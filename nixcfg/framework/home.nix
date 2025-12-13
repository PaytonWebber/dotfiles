{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      (pkgs.callPackage ({
        lib,
        fetchFromGitHub,
        cmake,
        hyprland,
        hyprlandPlugins,
      }:
        hyprlandPlugins.mkHyprlandPlugin pkgs.hyprland {
          pluginName = "hyprdeck";
          version = "0.1.0";
          src = /home/payton/projects/hyprdeck;
          nativeBuildInputs = [cmake];
          buildInputs = [];
          meta = {
            homepage = "https://github.com/PaytonWebber/hyprdeck";
            description = "Hyprland plugin for an main and deck like manual tiling layout";
            license = lib.licenses.mit;
            platforms = lib.platforms.linux;
            maintainers = with lib.maintainers; [payton];
          };
        }) {})
    ];
    settings = {
      # Monitor configuration
      monitor = [
        "eDP-1, 2880x1920@120, 0x0, 2"
        "DP-4, 3840x2160@60, 1440x0, 2"
      ];
      
      # Startup commands
      exec-once = [
        "sh ~/scripts/start.sh"
        "hypridle"
      ];
      
      # Variables
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "fuzzel";
      "$browser" = "firefox";
      "$mainMod" = "SUPER";
      
      # Environment variables
      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_NO_ATOMIC,1"
      ];
      
      # Input configuration
      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
        };
      };
      
      # Gestures
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_speed_to_force = 60;
        workspace_swipe_cancel_ratio = 0.5;
      };
      
      # Decoration
      decoration = {
        rounding = 10;
        "blur:enabled" = false;
        "shadow:enabled" = false;
      };
      
      # Master layout
      master = {
        mfact = 0.5;
        orientation = "left";
      };
      
      # General settings
      general = {
        border_size = 2;
        gaps_in = 1;
        gaps_out = 2;
        layout = "master";
        "col.active_border" = "rgb(ffbd5e)";
        "col.inactive_border" = "0x00000000";
      };
      
      # Misc settings
      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        disable_autoreload = false;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        middle_click_paste = false;
      };
      
      # Animations
      animations = {
        enabled = true;
      };
      animation = "global, 1, 1, default";
      
      # Key bindings
      bind = [
        # Brightness controls
        ", XF86MonBrightnessUp, exec, /home/payton/scripts/adjust_brightness.sh up"
        ", XF86MonBrightnessDown, exec, /home/payton/scripts/adjust_brightness.sh down"
        
        # Screenshot
        ", PRINT, exec, hyprshot -m active -m output -o /home/payton/screenshots"
        
        # Application shortcuts
        "$mainMod, Q, exec, $terminal"
        "$mainMod, E, exec, $browser"
        "$mainMod, RETURN, exec, $menu"
        "$mainMod, S, exec, /home/payton/scripts/search.sh search"
        
        # Window management
        "$mainMod, C, killactive,"
        "$mainMod, T, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, O, togglesplit,"
        "$mainMod, F, fullscreen"
        
        # Focus movement
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, u"
        "$mainMod, K, movefocus, d"
        
        # Window movement
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, J, movewindow, u"
        "$mainMod SHIFT, K, movewindow, d"
        
        # Workspace switching
        "$mainMod, 1, focusworkspaceoncurrentmonitor, 1"
        "$mainMod, 2, focusworkspaceoncurrentmonitor, 2"
        "$mainMod, 3, focusworkspaceoncurrentmonitor, 3"
        "$mainMod, 4, focusworkspaceoncurrentmonitor, 4"
        "$mainMod, 5, focusworkspaceoncurrentmonitor, 5"
        "$mainMod, 6, focusworkspaceoncurrentmonitor, 6"
        "$mainMod, TAB, togglespecialworkspace"
        
        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        
        # Deck layout controls
        "$mainMod SHIFT, N, deck:cyclenext"
        "$mainMod SHIFT, P, deck:cycleprev"
      ];
      
      # Volume controls (repeatable)
      binde = [
        ", XF86AudioRaiseVolume, exec, /home/payton/scripts/adjust_volume.sh up"
        ", XF86AudioLowerVolume, exec, /home/payton/scripts/adjust_volume.sh down"
        ", XF86AudioMute, exec, /home/payton/scripts/adjust_volume.sh mute"
      ];
      
      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "float, class:thunar, title:thunar"
      ];
    };
  };

  home.stateVersion = "25.05";
}
