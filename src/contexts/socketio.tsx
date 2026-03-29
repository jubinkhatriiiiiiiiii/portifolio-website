"use client";
import React, {
  createContext,
  Dispatch,
  ReactNode,
  SetStateAction,
  useEffect,
  useState,
} from "react";
import { io, Socket } from "socket.io-client";
import { useToast } from "@/components/ui/use-toast";

export type User = {
  id: string;
  socketId: string;
  name: string;
  avatar: string;
  color: string;
  isOnline: string;
  posX: number;
  posY: number;
  location: string;
  flag: string;
  lastSeen: string;
  createdAt: string;
};
export type Message = {
  id: string;
  sessionId: string;
  flag: string;
  country: string;
  username: string;
  avatar: string;
  color?: string;
  content: string;
  createdAt: string | Date;
}

type SocketContextType = {
  socket: Socket | null;
  users: User[];
  setUsers: Dispatch<SetStateAction<User[]>>;
  msgs: Message[];
  isCurrentUser: boolean
};

const INITIAL_STATE: SocketContextType = {
  socket: null,
  users: [],
  setUsers: () => { },
  msgs: [],
  isCurrentUser: false
};

export const SocketContext = createContext<SocketContextType>(INITIAL_STATE);

const SESSION_ID_KEY = "portfolio-site-session-id";

const SocketContextProvider = ({ children }: { children: ReactNode }) => {
  const [socket, setSocket] = useState<Socket | null>(null);
  const [users, setUsers] = useState<User[]>([]);
  const [msgs, setMsgs] = useState<Message[]>([]);
  const [isCurrentUser, setIsCurrentUser] = useState(false);
  const { toast } = useToast();

  // SETUP SOCKET.IO
  useEffect(() => {
    if (!process.env.NEXT_PUBLIC_WS_URL) {
      console.warn('NEXT_PUBLIC_WS_URL is not set. Real-time features will not work.');
      return;
    }
    
    console.log('Connecting to Socket.IO server:', process.env.NEXT_PUBLIC_WS_URL);
    
    const socket = io(process.env.NEXT_PUBLIC_WS_URL!, {
      auth: {
        sessionId: localStorage.getItem(SESSION_ID_KEY), // send on reconnect to restore session
      },
    });
    
    setSocket(socket);
    
    socket.on("connect", () => {
      console.log('Socket.IO connected:', socket.id);
    });
    
    socket.on("disconnect", () => {
      console.log('Socket.IO disconnected');
    });
    
    socket.on("connect_error", (error) => {
      console.error('Socket.IO connection error:', error);
    });
    
    socket.on("msgs-receive-init", (msgs) => {
      console.log('Received initial messages:', msgs.length);
      setMsgs(msgs);
    });
    
    socket.on("session", ({ sessionId }) => {
      console.log('Session ID received:', sessionId);
      localStorage.setItem(SESSION_ID_KEY, (sessionId));
    });

    socket.on("msg-receive", (msgs) => {
      console.log('New message received:', msgs);
      setMsgs((p) => [...p, msgs]);
    });
    
    socket.on("users-updated", (data: User[]) => {
      console.log('Users updated:', data.length, 'users');
      setUsers(data);
    });

    socket.on("warning", (data: { message: string }) => {
      console.log(data)
      toast({
        variant: "destructive",
        title: "System Warning",
        description: data.message,
      });
    });

    socket.on("msg-delete", (data: { id: number }) => {
      console.log(data)
      setMsgs((prev) => prev.filter((m) => Number(m.id) !== data.id));
    });
    
    return () => {
      socket.disconnect();
    };
  }, [toast]);
  const currentUser = users.find(u => u.socketId === socket?.id);

  return (
    <SocketContext.Provider value={{ socket: socket, users, setUsers, msgs, isCurrentUser }}>
      {children}
    </SocketContext.Provider>
  );
};

export default SocketContextProvider;
