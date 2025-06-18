# 🌿 Taha's Arch Linux Dotfiles

Welcome to my personal dotfiles repository!  
This setup is tailored for a clean and aesthetic Arch Linux experience using **Hyprland** as the dynamic tiling Wayland compositor.

---

## 📦 Components

This setup includes configurations for:

| Component    | Description                              |
|--------------|------------------------------------------|
| `hyprland`   | Main Wayland compositor + window manager |
| `hypridle`   | Idle daemon to manage lock/sleep         |
| `hyprlock`   | Stylish lock screen                      |
| `hyprpaper`  | Lightweight wallpaper daemon             |
| `waybar`     | Customizable status bar                  |
| `kitty`      | Fast, modern GPU-based terminal          |
| `wofi`       | Wayland launcher (Rofi-like)             |
| `fusuma`     | Touchpad gesture support                 |
| `wallpapers` | Curated personal wallpapers              |

---

## 📁 Directory Structure

```bash
.config/
├── fusuma/      # Touchpad gesture configurations
├── hypr/        # Main window manager config
├── hypridle/    # Idle management daemon
├── hyprlock/    # Screen locker
├── hyprpaper/   # Wallpaper manager
├── kitty/       # Terminal emulator
├── waybar/      # Status bar
├── wofi/        # Application launcher
└── wallpapers/  # Collection of minimal wallpapers
```

# ⚙️ Dependencies

**Core components needed:**

- `bash`
- `hyprland` `hyprpaper` `hypridle` `hyprlock`
- `waybar`
- `kitty`
- `wofi`
- `fusuma`

# 🚀 Installation

**Clone the repository:**
```bash
git clone https://github.com/TahaFayyaz1/Hyprland-Setup.git ~/.config
```

**Enable Fusuma gestures (for laptops):**
```bash
sudo gpasswd -a $USER input
systemctl --user enable fusuma
```

**Either reboot or, within Hyprland:**
```bash
hyprctl reload
```

# 🔧 Configuration Highlights

## Hyprland (`/hypr/hyprland.conf`)
- `Super+Return`: Open Kitty terminal
- `Super+Space`: Launch Wofi
- `Super+C`: Close active window
- Special Workspace for scratchpad terminals

## Waybar (`/waybar/config`)
- Workspace modules with active window tracking
- Information display for Time, Battery, Memory, CPU, Network and Audio
- Custom CSS for aesthetics
- Battery status with warning thresholds

## Hyprlock (`hypr/hyprlock.conf`)
- Clock with date display
- Custom Dynamic Welcome Message
- Blurred background effect

## Fusuma (`fusuma/config.yml`)
- 4-finger swipe: Volume Control (windows like)

# 🖼 Wallpapers
Located in `wallpapers/` directory.

# 🎨 Theming

- **GTK:** Catppuccin-Mocha

# ❓ Troubleshooting

- **Hyprland not starting:** Check logs  
  ```bash
  journalctl -u hyprland -b
  ```
- **Waybar missing modules:** Verify required utilities:  
  `pulseaudio`, `bluetoothctl`, `networkmanager`
- **Fusuma gestures not working:** Ensure user is in `input` group


> **Note:** This setup is optimized for 1920x1080 displays. Adjust resolutions in `hypr/hyprland.conf` and `waybar/config` for different screens.

---
