# 🌐 Share Your Portfolio Locally (Test with Friends)

Want to test the real-time chat with friends on the same WiFi? Here's how:

## 📱 Quick Setup for Local Network Sharing

### Step 1: Find Your Local IP Address

```bash
# On Linux/Mac
hostname -I | awk '{print $1}'

# Or
ifconfig | grep "inet " | grep -v 127.0.0.1

# On Windows
ipconfig | findstr IPv4
```

You'll get something like: `192.168.1.100`

### Step 2: Update Environment Variable

Edit `.env.local`:

```env
NEXT_PUBLIC_WS_URL=http://YOUR_IP:3001
```

Example:
```env
NEXT_PUBLIC_WS_URL=http://192.168.1.100:3001
```

### Step 3: Update Next.js to Listen on All Interfaces

Edit `../package.json` and change the dev script:

```json
{
  "scripts": {
    "dev": "next dev -H 0.0.0.0",
  }
}
```

Or run directly:
```bash
cd .. && next dev -H 0.0.0.0
```

### Step 4: Update Server to Listen on All Interfaces

The server is already configured to listen on `0.0.0.0` (all interfaces).

### Step 5: Restart Everything

```bash
# Stop current servers (Ctrl+C)
# Then restart
./dev-with-realtime.sh
```

### Step 6: Share URL with Friends

Give your friends this URL:
```
http://YOUR_IP:3000
```

Example: `http://192.168.1.100:3000`

## ✅ Testing Without Friends

You don't need friends to test! Just open multiple browser windows:

### Method 1: Multiple Tabs
1. Open http://localhost:3000
2. Open another tab → http://localhost:3000
3. Open Incognito window → http://localhost:3000

### Method 2: Different Browsers
1. Chrome → http://localhost:3000
2. Firefox → http://localhost:3000
3. Edge → http://localhost:3000

### Method 3: Mobile + Desktop
1. Desktop → http://localhost:3000
2. Phone (same WiFi) → http://YOUR_IP:3000

## 🎨 What You'll See

Once multiple users connect:
- ✅ User count increases
- ✅ Multiple cursors moving around
- ✅ Real-time chat messages
- ✅ Typing indicators
- ✅ User list with avatars
- ✅ "Invite a friend" message disappears

## 🔒 Firewall Issues?

If friends can't connect:

### Linux
```bash
# Allow port 3000 and 3001
sudo ufw allow 3000
sudo ufw allow 3001
```

### Mac
System Preferences → Security & Privacy → Firewall → Allow incoming connections

### Windows
Windows Defender Firewall → Allow an app → Node.js

## 🚀 For Real Internet Sharing

See `README-REALTIME.md` for deployment instructions to share with anyone on the internet.

## 📝 Quick Test Script

Save this as `test-local-network.sh`:

```bash
#!/bin/bash
IP=$(hostname -I | awk '{print $1}')
echo "🌐 Your local IP: $IP"
echo ""
echo "📱 Share this URL with friends on same WiFi:"
echo "   http://$IP:3000"
echo ""
echo "🔧 Make sure to update .env.local:"
echo "   NEXT_PUBLIC_WS_URL=http://$IP:3001"
```

Run it:
```bash
chmod +x test-local-network.sh
./test-local-network.sh
```
