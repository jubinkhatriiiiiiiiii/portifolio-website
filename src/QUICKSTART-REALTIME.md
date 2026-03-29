# Quick Start: Enable Real-time Chat Feature

Your portfolio already has the real-time chat UI components integrated! You just need to start the backend server.

## 🚀 Quick Setup (2 minutes)

### Step 1: Install Server Dependencies

```bash
npm install express socket.io cors
```

### Step 2: Start the Socket.IO Server

Open a new terminal and run:

```bash
./start-realtime.sh
```

Or manually:

```bash
node server.js
```

You should see:
```
Socket.IO server running on port 3001
```

### Step 3: Start Your Next.js App

In another terminal:

```bash
cd ..
npm run dev
```

### Step 4: Test It!

1. Open http://localhost:3000
2. Look for the **users button** in the top-right corner (shows user count)
3. Click it to open the chat panel
4. Open another browser tab/window to see real-time features:
   - See other users' cursors moving
   - Chat in real-time
   - See typing indicators

## ✅ What's Already Set Up

- ✅ Socket.IO client integrated
- ✅ Chat UI component in header
- ✅ Remote cursor tracking
- ✅ User presence system
- ✅ Environment variable configured (`.env.local`)

## 🎯 What You Just Added

- ✅ Socket.IO backend server (`server.js`)
- ✅ Server dependencies (`package-server.json`)
- ✅ Environment configuration (`.env.local`)

## 🔧 Troubleshooting

**Chat button not appearing?**
- Check if the server is running on port 3001
- Look for errors in browser console

**Can't connect?**
- Verify `.env.local` has: `NEXT_PUBLIC_WS_URL=http://localhost:3001`
- Restart the Next.js dev server after adding `.env.local`

**Port 3001 already in use?**
- Edit `server.js` and change the PORT
- Update `.env.local` with the new port

## 📦 Production Deployment

See `README-REALTIME.md` for detailed production deployment instructions.

## 🎨 Features

- Real-time chat with Discord-style UI
- Live cursor tracking (see where others are looking)
- User presence indicators
- Typing indicators
- Profile customization
- Sound effects
- Persistent sessions
