# StealthAccess - Invisible Authentication System

**StealthAccess** is a creative security concept for Windows, designed to authenticate a user **without using a traditional password**.  
Instead, you prove your identity through secret actions after unlocking the system.


![grafik](https://github.com/user-attachments/assets/f8f54fc7-fe0e-47a7-8039-3627f33114d9)


---

## 🔥 Features

- **Invisible Authentication**:  
  No password entry — just perform your secret actions.

- **Three alternative authentication methods**:
  - **Hotkey based on the current minute**:  
    Press a hotkey (`CTRL + WIN + <dynamic letter>`) depending on the *unit digit* of the current time.
  - **Application sequence**:  
    Open **Calculator** ➔ **Settings** ➔ **Explorer**.
  - **Mouse gesture (experimental)**:  
    (deprecated) Shake the mouse for 5 seconds ➔ pause 2 seconds ➔ shake again.

- **Automatic Lock**:  
  If no valid authentication is performed within 2 minutes, the computer locks itself.

- **Real-time Notifications**:  
  Tray messages keep you informed about your authentication status.

- **Fail-Safe Timer**:  
  No authentication → system lock.

---

## 💻 How it works

1. The script monitors **session unlock events** (e.g., after waking from sleep or unlocking the computer).
2. After unlocking:
   - A **2-minute timer** starts.
   - You must perform one of the secret methods listed above.
3. If you succeed → **access granted silently**.
4. If you fail → **Windows locks again**.

---

## 📈 Future Ideas

- Randomize required actions based on day/time
- Smartphone (Bluetooth) verification
- Adaptive "normal behavior" detection
- Multi-user version

---

## ⚡ Technologies

- AutoHotkey v1.1 (easy to adapt to v2)
- Windows API (`LockWorkStation`)
- Lightweight CPU usage (timers only during checks)

---

## 📜 License

Released under the [MIT License](LICENSE).  
Free to use, modify, and share.

---

## 🚀 Quick Start

1. Install [AutoHotkey](https://www.autohotkey.com/)
2. Download or clone this repository
3. Run `StealthAccess.ahk`
4. Unlock your system with style and stealth! 😎

---

## 🤝 Acknowledgement

This project was designed with AI assistance (ChatGPT).

---

# 🖼️ Banner
![grafik](https://github.com/user-attachments/assets/3fbd9b0a-758e-4062-a231-4c49c26434fa)



---

