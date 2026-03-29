# 🐛 Debug Real-time Chat Feature

## Step-by-Step Debugging

### 1. Restart Both Servers

Stop the current servers (Ctrl+C) and restart:

```bash
./dev-with-realtime.sh
```

### 2. Check Server Logs

In the terminal running the servers, you should see:
```
Socket.IO server running on port 3001
✅ User connected: [socket-id]
👥 Total users online: 1
📤 Broadcasting user list: 1 users
```

### 3. Check Browser Console

Open http://localhost:3000 and press F12 to open Developer Tools.

In the Console tab, you should see:
```
Connecting to Socket.IO server: http://localhost:3001
Socket.IO connected: [socket-id]
Session ID received: [session-id]
Received initial messages: 0
Users updated: 1 users
```

### 4. Open Second Tab/Window

Open an incognito window or new tab to http://localhost:3000

**Server logs should show:**
```
✅ User connected: [new-socket-id]
👥 Total users online: 2
📤 Broadcasting user list: 2 users
```

**Both browser consoles should show:**
```
Users updated: 2 users
```

### 5. Check the Chat UI

Click the users button (👥) in the top-right corner.

You should see:
- User count badge showing "2"
- User list showing 2 users
- "Invite a friend" message should be GONE
- Both users' cursors visible

## Common Issues

### Issue 1: "NEXT_PUBLIC_WS_URL is not set"

**Console shows:** `NEXT_PUBLIC_WS_URL is not set`

**Fix:**
```bash
# Check if .env.local exists
cat .env.local

# Should show:
# NEXT_PUBLIC_WS_URL=http://localhost:3001

# If missing, create it:
echo "NEXT_PUBLIC_WS_URL=http://localhost:3001" > .env.local

# IMPORTANT: Restart Next.js dev server
cd .. && npm run dev
```

### Issue 2: Connection Error

**Console shows:** `Socket.IO connection error: Error: ...`

**Fix:**
```bash
# Check if server is running
curl http://localhost:3001

# Should return JSON with status: "ok"

# If not running, start it:
node server.js
```

### Issue 3: Users Not Updating

**Console shows:** `Socket.IO connected` but no "Users updated" message

**Fix:** The socket context wasn't listening to `users-updated` event. This is now fixed in the updated code.

**Verify the fix:**
1. Stop servers (Ctrl+C)
2. Restart: `./dev-with-realtime.sh`
3. Hard refresh browser (Ctrl+Shift+R or Cmd+Shift+R)
4. Check console for "Users updated" messages

### Issue 4: Port Already in Use

**Error:** `EADDRINUSE: address already in use :::3001`

**Fix:**
```bash
# Find process using port 3001
lsof -i :3001

# Kill it
kill -9 <PID>

# Or use a different port
# Edit server.js: const PORT = 3002
# Edit .env.local: NEXT_PUBLIC_WS_URL=http://localhost:3002
```

### Issue 5: CORS Error

**Console shows:** `Access to XMLHttpRequest ... has been blocked by CORS`

**Fix:** Already fixed in server.js with `origin: "*"` for local testing.

## Manual Testing Checklist

- [ ] Server running on port 3001
- [ ] Next.js running on port 3000
- [ ] `.env.local` exists with correct URL
- [ ] Browser console shows "Socket.IO connected"
- [ ] Browser console shows "Users updated: 1 users"
- [ ] Server logs show "User connected"
- [ ] Open second tab/window
- [ ] Server logs show "Total users online: 2"
- [ ] Both browsers show "Users updated: 2 users"
- [ ] Click users button (👥) shows 2 users
- [ ] "Invite a friend" message is gone
- [ ] Can see both cursors moving
- [ ] Can send chat messages

## Quick Test Commands

```bash
# Test server is running
curl http://localhost:3001

# Check environment variable
cat .env.local

# Check if ports are in use
lsof -i :3000
lsof -i :3001

# View server logs with timestamps
node server.js | ts '[%Y-%m-%d %H:%M:%S]'
```

## Still Not Working?

1. **Clear browser cache and localStorage:**
   - Open DevTools (F12)
   - Application tab → Storage → Clear site data
   - Hard refresh (Ctrl+Shift+R)

2. **Check file changes were saved:**
   ```bash
   # Verify socketio.tsx has users-updated listener
   grep -n "users-updated" contexts/socketio.tsx
   
   # Should show line with: socket.on("users-updated", ...)
   ```

3. **Try a different browser:**
   - Chrome + Firefox
   - Regular + Incognito

4. **Check Next.js is using the env variable:**
   - Add this to any page temporarily:
   ```tsx
   console.log('WS_URL:', process.env.NEXT_PUBLIC_WS_URL);
   ```

## Success Indicators

✅ Server logs show multiple users connected
✅ Browser console shows "Users updated: X users" where X > 1
✅ User count badge shows correct number
✅ User list shows multiple users
✅ "Invite a friend" message is gone
✅ Multiple cursors visible
✅ Chat messages sync between windows

## Need More Help?

Share these logs:
1. Server terminal output
2. Browser console output (F12 → Console tab)
3. Network tab showing WebSocket connection (F12 → Network → WS filter)
