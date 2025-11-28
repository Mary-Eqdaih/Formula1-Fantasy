# 🏎️ Formula 1 Fantasy (Flutter)

Formula 1 Fantasy is a beautifully crafted Flutter application that brings the thrilling world of Formula 1 racing right to your device.  
It’s designed for motorsport enthusiasts who want to **follow their favorite teams and drivers**, **stay updated on the latest and upcoming races**, and even **record personal race notes** — all in one elegant, offline-ready app.

Formula 1, often called the **pinnacle of motorsport**, is a global racing championship featuring cutting-edge technology, elite drivers, and legendary teams like **Ferrari**, **Red Bull Racing**, and **Mercedes**.  
Every race weekend combines **speed, strategy, and innovation** — and this app helps fans experience that energy interactively, whether tracking results, exploring teams, or keeping personal notes on each Grand Prix.

> 🎯 *Mobile-first, offline-capable, and beginner-friendly codebase powered by Provider state management.*

---

## ✨ Features

- 🏁 **Teams list** (current F1 season) with logos, nationality & wiki links
- 👨‍✈️ **Team details** showing drivers fetched dynamically from Ergast API
- 🧠 **Driver details** (name, nationality, code, birthdate, etc.)
- 🗒️ **Race Notes** — add, edit, delete, or browse personal race notes saved locally via SQLite
- ❤️ **Favorites** — mark and persist your favorite teams using SharedPreferences
- 🕹️ **Offline-first UX** — cached notes and favorites work even without internet
- 🧭 **About F1** — beautiful educational section summarizing F1 eras, cars, and records
- 💡 **Modern UI** — dark theme with authentic F1-style design and typography
- 🔐 **Firebase Authentication** — added for secure sign-in and sign-up
- 👤 **Profile**: View and edit user profile information, including favorite teams using Cloud Firestore
- 🏆 **Leaderboard**: Display season standings, sorted by points


---

## 🚀 Getting Started

```bash
# 1️⃣ Clone this repo
git clone https://github.com/Mary-Eqdaih/Formula-1-Flutter.git

# 2️⃣ Install dependencies
flutter pub get

# 3️⃣ Run the app
flutter run
```

Make sure to have an emulator or connected device ready.

---

## 🧩 Key Local Services

### 🔹 `LocalStorageData` (SharedPreferences)
- Saves user email (local session)
- Persists favorites (team IDs list)

### 🔹 `NotesDB` (SQLite)
- Manages CRUD operations for race notes
- Automatically initializes database on app launch


---
## UI Screenshots

Dark theme, mobile-first UI — built for F1 fans.
Tap any image to view full size.

| **Sign In** | **Sign Up** | **Home** | **Home 2** | **Race Details** |
|-------------|-------------|----------|------------|------------------|
| ![Sign In](assets/screenshots/sign_in.png) | ![Sign Up](assets/screenshots/sign_up.png) | ![Home](assets/screenshots/home.png) | ![Home 2](assets/screenshots/home(2).png) | ![Race Details](assets/screenshots/race_details.png) |

| **Teams** | **Team Details** | **Leaderboard** | **Favorites**                                  |
|-----------|------------------|-----------------|------------------------------------------------|
| ![Teams](assets/screenshots/teams.png) | ![Team Details](assets/screenshots/team_details.png) | ![Leaderboard](assets/screenshots/leaderboard.png) | ![Favorites](assets/screenshots/favorites.png) | 

| **Add Note** | **Notes List** | **Edit Note** | **Notes After Edit** |
|--------------|----------------|---------------|----------------------|
| ![Add Note](assets/screenshots/add_note.png) | ![Notes](assets/screenshots/notes.png) | ![Edit Note](assets/screenshots/edit_note.png) | ![After Edit](assets/screenshots/notes_after_edit.png) |

| **Settings** | **Profile** | **About F1** | ** Latest F1 News**                     |
|--------------|-------------|-------------|-----------------------------------------|
| ![Settings](assets/screenshots/settings.png) | ![Profile](assets/screenshots/profile.png) |![About F1](assets/screenshots/about_f1.png) | ![F1 News](assets/screenshots/news.png) |


---




## 🌍 Why Formula 1?

Formula 1 is not just racing — it’s **engineering, innovation, and precision at 300 km/h**.  
This app was built to make that spirit more interactive, helping fans experience the strategic and technical side of the sport while also giving them tools to take personal race notes, follow teams, and celebrate their passion digitally.

---
## 🙋‍♂️ By

- GitHub: [@Mary-Eqdaih](https://github.com/Mary-eqdaih)

