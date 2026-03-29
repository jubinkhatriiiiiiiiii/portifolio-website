# 🖱️ How Cursor Tracking Works - Technical Explanation

## Overview

The cursor tracking feature shows where other users are looking on your website in real-time. Each user sees colored cursors representing other visitors, complete with their location and recent chat messages.

---

## 🔄 The Flow

```
User A moves mouse
    ↓
useMouse hook captures position (x, y)
    ↓
useThrottle limits updates to every 200ms
    ↓
Socket.IO emits "cursor-change" event to server
    ↓
Server broadcasts to all other users
    ↓
User B receives "cursor-changed" event
    ↓
Updates User A's position in state
    ↓
RemoteCursors component renders User A's cursor at new position
    ↓
Framer Motion animates smooth movement
```

---

## 📦 Components Breakdown

### 1. Mouse Position Tracking (`use-mouse.tsx`)

**Purpose:** Captures the user's mouse position in real-time

```typescript
const { x, y } = useMouse({ allowPage: true });
```

**How it works:**
- Listens to `mousemove` event on the window
- `allowPage: true` means it tracks position relative to entire page (not just viewport)
- Returns `x` and `y` coordinates
- Updates on every mouse movement

**Key Code:**
```typescript
const handleMouseMove = (e: MouseEvent) => {
  setX(allowPage ? e.pageX : e.clientX);  // Page position (includes scroll)
  setY(allowPage ? e.pageY : e.clientY);  // Page position (includes scroll)
};
```

**Why `pageX/pageY` instead of `clientX/clientY`?**
- `clientX/clientY` = position relative to viewport (visible area)
- `pageX/pageY` = position relative to entire document (includes scrolled area)
- This ensures cursors stay in correct position even when users scroll

---

### 2. Throttling (`use-throttle.tsx`)

**Purpose:** Limits how often cursor updates are sent to prevent network spam

```typescript
const handleMouseMove = useThrottle((x, y) => {
  socket?.emit("cursor-change", { pos: { x, y }, socketId: socket.id });
}, 200);
```

**How it works:**
- Without throttling: Mouse moves 60+ times per second = 60+ network requests/sec
- With throttling: Only sends update every 200ms = 5 requests/sec
- Saves bandwidth and reduces server load

**Example:**
```
Without throttle:
Time: 0ms   100ms  200ms  300ms  400ms  500ms
Send: ✓     ✓      ✓      ✓      ✓      ✓     (6 requests)

With throttle (200ms):
Time: 0ms   100ms  200ms  300ms  400ms  500ms
Send: ✓     ✗      ✓      ✗      ✓      ✗     (3 requests)
```

---

### 3. Remote Cursors Component (`remote-cursors.tsx`)

**Purpose:** Displays other users' cursors on your screen

#### Part A: Sending Your Position

```typescript
// Track your mouse position
const { x, y } = useMouse({ allowPage: true });

// Send to server (throttled to 200ms)
const handleMouseMove = useThrottle((x, y) => {
  socket?.emit("cursor-change", {
    pos: { x, y },
    socketId: socket.id,
  });
}, 200);

// Trigger on mouse movement
useEffect(() => {
  if (isMobile) return;  // Don't track on mobile
  handleMouseMove(x, y);
}, [x, y, isMobile]);
```

**What happens:**
1. Your mouse moves
2. `useMouse` captures new position
3. `useEffect` triggers
4. `handleMouseMove` (throttled) sends to server
5. Server broadcasts to all other users

#### Part B: Receiving Others' Positions

```typescript
useEffect(() => {
  if (!socket || isMobile) return;
  
  // Listen for cursor updates from other users
  socket.on("cursor-changed", (data) => {
    setUsers((prev: User[]) => {
      const newUsers = [...prev];
      const user = newUsers.find(u => u.socketId === data.socketId);
      
      if (user) {
        // Update existing user's position
        user.posX = data.pos.x;
        user.posY = data.pos.y;
      } else {
        // Add new user
        newUsers.push({ ...data });
      }
      
      return newUsers;
    });
  });
  
  return () => {
    socket.off("cursor-changed");
  };
}, [socket, isMobile, setUsers]);
```

**What happens:**
1. Server sends "cursor-changed" event
2. Contains: `{ socketId, pos: { x, y } }`
3. Find user in state by `socketId`
4. Update their `posX` and `posY`
5. React re-renders with new position

#### Part C: Rendering Cursors

```typescript
return (
  <div className="absolute top-0 left-0 w-full h-full z-10">
    {users
      .filter((user) => user.socketId !== socket?.id)  // Don't show your own cursor
      .map((user) => (
        <Cursor
          key={user.socketId}
          x={user.posX}
          y={user.posY}
          color={user.color}
          socketId={user.socketId}
          avatar={user.avatar}
          headerText={`${user.location} ${user.flag}`}
        />
      ))}
  </div>
);
```

**What happens:**
1. Filter out your own cursor (you don't need to see it)
2. Map over all other users
3. Render a `Cursor` component for each user
4. Pass their position, color, avatar, etc.

---

### 4. Individual Cursor Component

**Purpose:** Renders a single user's cursor with smooth animation

```typescript
const Cursor = ({ x, y, color, socketId, avatar, headerText }) => {
  return (
    <motion.div
      animate={{ x: x, y: y }}  // Animate to new position
      transition={{
        duration: 0.2,
        ease: "easeOut"
      }}
    >
      {/* Cursor icon */}
      <MousePointer2 style={{ color: color }} />
      
      {/* Avatar pill with user info */}
      <motion.div>
        <img src={getAvatarUrl(avatar)} />
        <div>{headerText}</div>  {/* Location + Flag */}
        {msgText && <div>{msgText}</div>}  {/* Recent message */}
      </motion.div>
    </motion.div>
  );
};
```

**Features:**

1. **Smooth Animation (Framer Motion)**
   ```typescript
   animate={{ x: x, y: y }}
   transition={{ duration: 0.2, ease: "easeOut" }}
   ```
   - Animates cursor movement smoothly
   - Takes 0.2 seconds to move to new position
   - Uses easing for natural feel

2. **User Info Display**
   - Shows on hover or cursor movement
   - Displays location and flag
   - Shows recent chat message (if any)
   - Auto-hides after 3 seconds

3. **Message Display**
   ```typescript
   useEffect(() => {
     const lastMsgSessionId = msgs.at(-1)?.sessionId;
     const cursorUserId = users.find(u => u.socketId === socketId)?.id;
     
     if (lastMsgSessionId === cursorUserId) {
       // This user just sent a message
       setMsgText(lastMsgContent.slice(0, 30) + "...");
       
       // Hide after calculated time
       setTimeout(() => setMsgText(""), timeToRead);
     }
   }, [msgs]);
   ```
   - When a user sends a message
   - Their cursor shows the message text
   - Displays for 4+ seconds (based on length)
   - Then fades away

---

## 🔄 Complete Data Flow Example

### Scenario: User A moves mouse, User B sees it

**User A's Browser:**
```
1. Mouse moves to (500, 300)
2. useMouse captures: x=500, y=300
3. useEffect triggers
4. handleMouseMove (throttled) checks: "Has 200ms passed?"
5. If yes: socket.emit("cursor-change", { pos: { x: 500, y: 300 }, socketId: "abc123" })
```

**Server (Render):**
```
1. Receives: "cursor-change" from User A
2. Updates User A's position in memory: users.get("abc123").posX = 500, posY = 300
3. Broadcasts to all other users: socket.broadcast.emit("cursor-changed", { socketId: "abc123", pos: { x: 500, y: 300 } })
```

**User B's Browser:**
```
1. Receives: "cursor-changed" event
2. Data: { socketId: "abc123", pos: { x: 500, y: 300 } }
3. Updates state: Find user "abc123", set posX=500, posY=300
4. React re-renders
5. Cursor component animates to new position
6. Framer Motion smoothly moves cursor from old position to (500, 300)
```

---

## 🎨 Visual Representation

```
┌─────────────────────────────────────────────────────────────┐
│                    User A's Screen                          │
│                                                             │
│  [Your cursor - not shown]                                 │
│                                                             │
│                    🖱️ User B (blue)                        │
│                    📍 New York 🇺🇸                         │
│                                                             │
│                                                             │
│         🖱️ User C (green)                                  │
│         📍 London 🇬🇧                                       │
│         💬 "Hello everyone!"                                │
│                                                             │
└─────────────────────────────────────────────────────────────┘

Every 200ms:
- User A sends their position to server
- Server broadcasts to User B and User C
- User B and User C see User A's cursor move
```

---

## 🔧 Technical Details

### Why Throttle to 200ms?

**Without throttling:**
- Mouse moves ~60 times per second
- 60 network requests per second per user
- 10 users = 600 requests/sec to server
- Expensive and unnecessary

**With 200ms throttling:**
- 5 updates per second per user
- 10 users = 50 requests/sec to server
- 12x reduction in network traffic
- Still feels smooth and real-time

### Why Use pageX/pageY?

**Scenario:** User A is scrolled down 1000px

**With clientX/clientY:**
```
User A's cursor at top of viewport: clientY = 100
User B sees cursor at: y = 100 (wrong! Should be 1100)
```

**With pageX/pageY:**
```
User A's cursor at top of viewport: pageY = 1100 (includes scroll)
User B sees cursor at: y = 1100 (correct!)
```

### Why Filter Out Your Own Cursor?

```typescript
.filter((user) => user.socketId !== socket?.id)
```

- You already see your own cursor (native browser cursor)
- No need to render a duplicate
- Saves rendering performance
- Prevents confusion

### Mobile Optimization

```typescript
const isMobile = useMediaQuery("(max-width: 768px)");

if (isMobile) return;  // Don't track cursors on mobile
```

**Why?**
- Mobile devices don't have cursors
- Touch events are different from mouse events
- Saves battery and bandwidth
- Better mobile performance

---

## 🎯 Key Takeaways

1. **Mouse Tracking:** `useMouse` hook captures position
2. **Throttling:** Limits updates to 5 per second (200ms)
3. **Broadcasting:** Socket.IO sends to all other users
4. **State Management:** Updates user positions in React state
5. **Rendering:** Maps over users and renders cursor components
6. **Animation:** Framer Motion smoothly animates movement
7. **User Info:** Shows location, flag, and recent messages
8. **Optimization:** Throttling, mobile detection, filtering own cursor

---

## 🔍 Code Locations

- **Mouse tracking:** `hooks/use-mouse.tsx`
- **Throttling:** `hooks/use-throttle.tsx`
- **Cursor rendering:** `components/realtime/remote-cursors.tsx`
- **Server logic:** `socket-server/index.js` (cursor-change event)
- **User state:** `contexts/socketio.tsx`

---

## 💡 How to Customize

### Change Update Frequency

```typescript
// Faster updates (100ms = 10 per second)
const handleMouseMove = useThrottle((x, y) => {
  socket?.emit("cursor-change", { pos: { x, y } });
}, 100);

// Slower updates (500ms = 2 per second)
const handleMouseMove = useThrottle((x, y) => {
  socket?.emit("cursor-change", { pos: { x, y } });
}, 500);
```

### Change Cursor Colors

Colors are assigned randomly on the server:
```javascript
// In socket-server/index.js
color: `#${Math.floor(Math.random()*16777215).toString(16)}`
```

### Add Click Animation

Currently marked as TODO:
```typescript
// TODO: add clicking animation
```

You could add:
```typescript
socket.on("user-clicked", (data) => {
  // Show ripple effect at cursor position
});
```

---

## 🎉 Summary

The cursor tracking creates a collaborative browsing experience by:
1. Tracking each user's mouse position
2. Broadcasting it to all other users via Socket.IO
3. Rendering animated cursors at those positions
4. Showing user info and recent messages
5. All optimized with throttling and smart filtering

It's like Google Docs' cursor tracking, but for your entire website! 🚀
