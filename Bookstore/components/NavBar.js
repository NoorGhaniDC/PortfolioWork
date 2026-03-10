import Link from 'next/link';
import { useRouter } from 'next/router';
import { useAuth } from './context/AuthContext';
import LoginForm from './LoginForm';

const NavBar = () => {
    const router = useRouter();
    const currentPath = router.pathname;
    const { user, logout } = useAuth();

    return (
        <nav className="navbar">
            <div className="container nav-container">
                
                {/* LEFT SIDE: Brand + Navigation Links */}
                <div className="nav-left">
                    <Link href="/" className="nav-brand">
                        📚 BookStore
                    </Link>

                    <div className="nav-links">
                        <Link href="/" className={currentPath === '/' ? 'active' : ''}>
                            Home
                        </Link>
                        <Link href="/products" className={currentPath === '/products' ? 'active' : ''}>
                            Products
                        </Link>
                        {user && (
                            <Link href="/dashboard" className={currentPath === '/dashboard' ? 'active' : ''}>
                                Dashboard
                            </Link>
                        )}
                    </div>
                </div>

                {/* RIGHT SIDE: Authentication */}
                <div className="nav-auth">
                    {user ? (
                        <div className="user-info">
                            <span className="user-email">{user.email}</span>
                            <button onClick={logout} className="logout-btn">Logout</button>
                        </div>
                    ) : (
                        <LoginForm />
                    )}
                </div>
            </div>
        </nav>
    );
};

export default NavBar;