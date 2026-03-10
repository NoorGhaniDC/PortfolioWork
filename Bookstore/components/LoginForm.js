import { useState } from 'react';
import { useAuth } from './context/AuthContext';

export default function LoginForm() {
    const { login } = useAuth();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        
        const result = await login(email, password);
        if (!result.success) {
            setError(result.message || 'Login failed');
        }
    };

    return (
        <form onSubmit={handleSubmit} className="login-form">
            <input 
                type="email" 
                placeholder="Email" 
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="input-field"
            />
            <input 
                type="password" 
                placeholder="Password" 
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                className="input-field"
            />
            <button type="submit">Login</button>
            {error && <span style={{color: 'red', marginLeft: '10px'}}>{error}</span>}
        </form>
    );
}