import bcrypt from 'bcryptjs';
import jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET || 'fallback-secret';
const JWT_EXPIRY = '7d';

const users = [
    {
        id: '1',
        email: 'admin@blog.com', 
        password: '$2b$10$apf3hHAZWWPJ3xjfX1wQ5uhkWAEYv2wRt5R6.mYoKiGkOFHILJdF2', // admin123
        role: 'admin'
    },
    {
        id: '2',
        email: 'author@blog.com',
        password: '$2b$10$9cah51cGxBqRa1k.nh5GR.hlH8xknE0LBXn2BiKUeXh5aH6ja026m', // author123
        role: 'author'
    }
];

export function hashPassword(password){
    return bcrypt.hashSync(password, 10);
}

export function verifyPassword(password, hashed){
    return bcrypt.compareSync(password, hashed);
}

export function generateToken(user){
    return jwt.sign(
        { userId: user.id, email: user.email, role: user.role },
        JWT_SECRET,
        { expiresIn: JWT_EXPIRY }
    );
}

export function verifyToken(token){
    try {
        return jwt.verify(token, JWT_SECRET);
    } catch(err){
        return null;
    }
}

export function findUserByEmail(email){
    return users.find(u => u.email === email);
}