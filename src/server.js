const express = require('express');
const { createServer } = require('http');
const { Server } = require('socket.io');
const cors = require('cors');

const app = express();
app.use(cors());

// Health check endpoint
app.get('/', (req, res) => {
  res.json({
    status: 'ok',
    message: 'Socket.IO server is running',
    timestamp: new Date().toISOString(),
    connections: io.engine.clientsCount
  });
});

const httpServer = createServer(app);
const io = new Server(httpServer, {
  cors: {
    origin: process.env.CLIENT_URL || "*", // Allow all origins for local testing
    methods: ["GET", "POST"],
    credentials: true
  }
});

// Store users and messages in memory (use a database in production)
const users = new Map();
const messages = [];
const sessions = new Map();

io.use((socket, next) => {
  const sessionId = socket.handshake.auth.sessionId;
  if (sessionId && sessions.has(sessionId)) {
    const session = sessions.get(sessionId);
    socket.sessionId = sessionId;
    socket.userId = session.userId;
    return next();
  }
  
  // Create new session
  const newSessionId = require('crypto').randomUUID();
  socket.sessionId = newSessionId;
  socket.userId = newSessionId;
  next();
});

io.on('connection', async (socket) => {
  console.log('✅ User connected:', socket.id);

  // Save session
  sessions.set(socket.sessionId, {
    userId: socket.userId,
    socketId: socket.id
  });
  
  socket.emit('session', { sessionId: socket.sessionId });

  // Get user location (simplified - use a proper IP geolocation service)
  const userLocation = 'Unknown';
  const userFlag = '🌍';

  // Create or update user
  const user = {
    id: socket.userId,
    socketId: socket.id,
    name: `User${Math.floor(Math.random() * 1000)}`,
    avatar: `avatar-${Math.floor(Math.random() * 20) + 1}`,
    color: `#${Math.floor(Math.random()*16777215).toString(16)}`,
    isOnline: 'true',
    posX: 0,
    posY: 0,
    location: userLocation,
    flag: userFlag,
    lastSeen: new Date().toISOString(),
    createdAt: new Date().toISOString()
  };

  users.set(socket.id, user);
  console.log(`👥 Total users online: ${users.size}`);

  // Send initial messages
  socket.emit('msgs-receive-init', messages.slice(-50)); // Last 50 messages

  // Broadcast updated user list
  const userList = Array.from(users.values());
  console.log('📤 Broadcasting user list:', userList.length, 'users');
  io.emit('users-updated', userList);

  // Handle cursor movement
  socket.on('cursor-change', (data) => {
    const user = users.get(socket.id);
    if (user) {
      user.posX = data.pos.x;
      user.posY = data.pos.y;
      socket.broadcast.emit('cursor-changed', {
        socketId: socket.id,
        pos: data.pos
      });
    }
  });

  // Handle messages
  socket.on('msg-send', (data) => {
    const user = users.get(socket.id);
    if (!user) return;

    const message = {
      id: Date.now().toString(),
      sessionId: user.id,
      flag: user.flag,
      country: user.location,
      username: user.name,
      avatar: user.avatar,
      color: user.color,
      content: data.content,
      createdAt: new Date().toISOString()
    };

    messages.push(message);
    
    // Keep only last 100 messages
    if (messages.length > 100) {
      messages.shift();
    }

    io.emit('msg-receive', message);
  });

  // Handle typing indicator
  socket.on('typing', (data) => {
    const user = users.get(socket.id);
    if (user) {
      socket.broadcast.emit('typing-receive', {
        socketId: socket.id,
        username: user.name
      });
    }
  });

  // Handle profile updates
  socket.on('update-user', (data) => {
    const user = users.get(socket.id);
    if (user) {
      user.name = data.username || user.name;
      user.avatar = data.avatar || user.avatar;
      user.color = data.color || user.color;
      io.emit('users-updated', Array.from(users.values()));
    }
  });

  // Handle disconnect
  socket.on('disconnect', () => {
    console.log('❌ User disconnected:', socket.id);
    users.delete(socket.id);
    console.log(`👥 Total users online: ${users.size}`);
    io.emit('users-updated', Array.from(users.values()));
  });
});

const PORT = process.env.PORT || 3001;
httpServer.listen(PORT, () => {
  console.log(`Socket.IO server running on port ${PORT}`);
});
