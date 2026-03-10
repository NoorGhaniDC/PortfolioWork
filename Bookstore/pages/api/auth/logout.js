import * as cookie from 'cookie';
export default function handler(req, res) {
    if (req.method !== 'POST') {
        return res.status(405).end();
    }

    // Clear the cookie by setting maxAge to 0
    res.setHeader('Set-Cookie', cookie.serialize('token', '', {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'strict',
        maxAge: 0, 
        path: '/'
    }));

    res.status(200).json({ message: 'Logged out successfully' });
}

