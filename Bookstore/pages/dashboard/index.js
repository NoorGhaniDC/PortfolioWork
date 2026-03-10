import { useEffect } from 'react';
import { useRouter } from 'next/router';
import { useAuth } from '../../components/context/AuthContext';
import NavBar from '../../components/NavBar';
import Footer from '../../components/Footer';

export default function Dashboard() {
    const { user, loading } = useAuth();
    const router = useRouter();

    // Protect the route: If not logged in, kick them back to home
    useEffect(() => {
        if (!loading && (!user || user.role !== 'admin')) {
            router.push('/');
        }
    }, [user, loading, router]);

    // Show loading state while checking user
    if (loading) return <p>Loading...</p>;

    // If no user (and not loading), don't render anything (useEffect will redirect)
    if (!user) return null;

    return (
        <>
            <NavBar />
            <main style={{ padding: '20px' }}>
                <h1>Admin Dashboard</h1>
                <div style={{ background: '#f0f0f0', padding: '20px', borderRadius: '8px' }}>
                    <h2>Welcome, {user.email}</h2>
                    <p><strong>Role:</strong> {user.role}</p>
                    <p><strong>Status:</strong> Logged In</p>
                    <hr />
                    
                </div>
            </main>
            <Footer />
        </>
    );
}