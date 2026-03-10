import {verifyToken} from "@/lib/auth";

export default function handler(req, res) {

    // STEP 1: Look for the httpOnly cookie that we created at login
    const token = req.cookies.token;

    // STEP 2: If there is no cookie, user is not logged in
    if(!token){
        return res.status(401).json({message: 'No token - Not Logged In'})
    }

    // STEP 3: Decode and verify the JWT (check signature and expiry)
    const payload = verifyToken(token);

    // STEP 4: If token is invalid or expired, we reject it
    if(!payload){
        return res.status(401).json({error: 'Invalid or expired token'})
    }

    // STEP 5: Token is Good! Send back only the data our frontend needs
    // Never send back the password or raw token
    res.status(200).json({
        user: {
            id: payload.userId,
            email: payload.email,
            role: payload.role
        }
    });

}