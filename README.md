# SilentAuth - Invisible Authentication System

SilentAuth is a creative security concept for Windows, designed to authenticate a user without using a traditional password.
Instead, you prove your identity through secret actions after unlocking the system.
# 🔥 Features

    Invisible Authentication: No password entry required — just perform your secret actions.

    Three alternative authentication methods:

        Hotkey based on the current minute:
        Press a hotkey (CTRL + WIN + <dynamic letter>) based on the unit place of the current minute.

        Opening specific applications in a sequence:
        Open the Calculator, then Settings, then Explorer.

        Special Mouse Gesture (currently optional):
        (Deprecated — was experimental) — Shake the mouse for 5 seconds, stop for 2 seconds, then shake again.

    Automatic Lock:
    If no valid authentication is performed within 2 minutes, the computer will automatically lock itself.

    Real-time Tray Notifications:
    Tray tips inform you during the process (for debug and usage clarity).

    Fail-Safe Timer:
    No authentication = no access.

# 💻 How it works

    The script monitors session unlocks (e.g., after waking from sleep or logging back in).

    After unlocking:

        A 2-minute timer starts.

        You must perform one of the secret authentication methods.

    If you succeed — access is silently granted.

    If you fail — the system will lock again automatically.

# 🔐 Future Ideas (optional):

    Randomized sequences

    Smartphone integration

    Adaptive learning of normal behavior patterns

    Multi-user setups

# ⚡ Technologies

    AutoHotkey v1.1 (can be ported to v2 easily)

    Windows APIs (LockWorkStation)

    Minimal CPU overhead (timers run only during active checks)

# 📜 License

Feel free to use, modify, and distribute under the MIT License.
(Or adjust depending on your preference.)

# 🎯 Quick Start

    Install AutoHotkey

    Download the script

    Run SilentAuth.ahk
