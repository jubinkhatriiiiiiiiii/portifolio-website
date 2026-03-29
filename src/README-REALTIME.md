# Real-time Chat & Cursor Feature Setup

This portfolio includes a Discord-style real-time chat and collaborative cursor feature powered by Socket.IO.

## Features

- Real-time chat in a "#general" channel
- Live cursor tracking (see other visitors' mouse movements)
- User presence indicators
- Typing indicators
- Profile customization (name, avatar, color)
- Sound effects for messages
- Persistent sessions

## Setup Instructions

### 1. Install Server Dependencies

The Socket.IO server is separate from the Next.js app. Install its dependencies:

```bash
# In the src directory
npm install --prefix . express socket.io cors
# Or if you want dev dependencies
npm install --prefix . express socket.io cors nodemon --save-dev
```

Or create a separate server directory:

```bash
cd ..
mkdir server
cd server
npm init -y
npm install express socket.io cors
npm install nodemon --save-dev
```

Then move `server.js` and `package-server.json` to that directory.

### 2. Configure Environment Variables

Create a `.env.local` file in the root directory (already created):

```env
NEXT_PUBLIC_WS_URL=http://localhost:3001
```

For production, set this to your deployed Socket.IO server URL.

### 3. Start the Socket.IO Server

In a separate terminal:

```bash
# If using the server.js in src directory
node server.js

# Or with nodemon for auto-reload
npx nodemon server.js
```

The server will start on port 3001.

### 4. Start the Next.js App

In another terminal:

```bash
npm run dev
```

The app will start on port 3000.

### 5. Test the Feature

1. Open http://localhost:3000 in your browser
2. Look for the floating users button (with user count) in the top-right
3. Click it to open the chat panel
4. Open another browser window/tab to see real-time interaction
5. Move your mouse to see cursors, send messages, etc.

## Production Deployment

### Deploy Socket.IO Server

You can deploy the Socket.IO server to:

- **Railway**: Easy Node.js deployment
- **Render**: Free tier available
- **Heroku**: Classic choice
- **DigitalOcean App Platform**: Simple deployment
- **AWS/GCP/Azure**: More control

Example for Railway:
1. Create a new project
2. Connect your repo
3. Set root directory to where server.js is
4. Set start command: `node server.js`
5. Add environment variable: `CLIENT_URL=https://your-portfolio.com`

### Update Environment Variable

Update `.env.local` (or your hosting platform's env vars):

```env
NEXT_PUBLIC_WS_URL=https://your-socket-server.railway.app
```

## Customization

### Change Server Port

Edit `server.js`:

```javascript
const PORT = process.env.PORT || 3001; // Change 3001 to your preferred port
```

### Add IP Geolocation

Install a geolocation package:

```bash
npm install geoip-lite
```

Update `server.js`:

```javascript
const geoip = require('geoip-lite');

// In the connection handler
const ip = socket.handshake.address;
const geo = geoip.lookup(ip);
const userLocation = geo ? geo.city || geo.country : 'Unknown';
const userFlag = geo ? getFlag(geo.country) : '🌍';
```

### Persist Messages to Database

Replace the in-memory `messages` array with a database (MongoDB, PostgreSQL, etc.).

## Troubleshooting

### Chat not connecting

1. Check if Socket.IO server is running: `curl http://localhost:3001`
2. Check browser console for errors
3. Verify `NEXT_PUBLIC_WS_URL` is set correctly
4. Check CORS settings in `server.js`

### Cursors not showing

1. Ensure multiple users are connected
2. Check browser console for WebSocket errors
3. Verify cursor events are being emitted (check server logs)

### Messages not persisting

The current implementation stores messages in memory. They'll be lost on server restart. Implement database storage for persistence.

## Architecture

```
┌─────────────────┐         WebSocket          ┌──────────────────┐
│   Next.js App   │ ◄─────────────────────────► │  Socket.IO       │
│   (Port 3000)   │                              │  Server          │
│                 │                              │  (Port 3001)     │
│  - UI/UX        │                              │  - User mgmt     │
│  - Components   │                              │  - Message store │
│  - Socket.io    │                              │  - Event routing │
│    client       │                              │                  │
└─────────────────┘                              └──────────────────┘
```

## Security Considerations

For production:

1. Add rate limiting to prevent spam
2. Implement authentication
3. Sanitize message content (XSS prevention)
4. Use HTTPS/WSS for encrypted connections
5. Add message moderation
6. Implement user banning/blocking
7. Add CAPTCHA for new users

## License

Same as the main project.
