# 🎮 GameMaker + GitHub Team Workflow (Simple Guide)

Kia ora 👋

This guide will help you work on our GameMaker project **as a team** using GitHub — step by step.

You don’t need to be a coder to follow this 👍

---

# 🚀 FIRST TIME SETUP (ONLY DO ONCE)

## 1. Clone the project

Ask for the repo link, then run:

```bash
git clone REPO-LINK-HERE
```

## 2. Open the project

* Open the folder you just downloaded
* Open the `.yyp` file in GameMaker

---

# 🧠 DAILY WORKFLOW (DO THIS EVERY TIME)

## ✅ Step 1: Get latest version

Before you start:

```bash
git pull
```

---

## ✅ Step 2: Create your own branch

This keeps your work separate and safe

```bash
git checkout -b your-name-feature
```

Example:

```bash
git checkout -b jayden-ui
```

---

## ✅ Step 3: Do your work

Work inside GameMaker like normal 👍

⚠️ IMPORTANT:

* Only work on YOUR assigned part
* Don’t edit someone else’s objects unless you ask first

---

## ✅ Step 4: Save your work

When you're done:

```bash
git add .
git commit -m "what you did"
```

Example:

```bash
git commit -m "Added main menu UI"
```

---

## ✅ Step 5: Upload your work

```bash
git push
```

---

## ✅ Step 6: Merge into main (important)

Go to GitHub:

* Open your branch
* Click **"Compare & pull request"**
* Click **"Merge"**

---

# 👥 TEAM RULES (READ THIS)

## 🟢 Rule 1: Always pull first

```bash
git pull
```

---

## 🟢 Rule 2: Only work on your part

### Example roles:

* Person A → Player + game logic
* Person B → UI + menus
* Person C → Levels + rooms

---

## 🟢 Rule 3: Push your work when done

Don’t leave work uncommitted

---

## 🔴 Rule 4: Don’t work on the same object at the same time

Example:

❌ Both editing `obj_player`

👉 This WILL break the project

---

# ⚠️ IMPORTANT GAME MAKER NOTE

GameMaker files don’t merge nicely.

That means:

👉 It’s better to **avoid conflicts** than fix them

---

# 💡 TIPS FOR SUCCESS

* Keep your work small and simple
* Push regularly (don’t wait too long)
* Ask before changing shared systems

---

# 🆘 IF SOMETHING BREAKS

Don’t panic 😅

1. Stop working
2. Ask the team
3. We’ll fix it together

---

# ✅ QUICK CHECKLIST

Before you finish for the day:

* [ ] I ran `git pull`
* [ ] I worked on my assigned part
* [ ] I committed my changes
* [ ] I pushed my branch
* [ ] I made a pull request

---

# 🎯 GOAL

Work together without overwriting each other’s work 👍

---

If you’re unsure about anything — just ask 🙌
