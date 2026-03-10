import Head from 'next/head';
import Link from 'next/link';
import NavBar from '../components/NavBar';
import Footer from '../components/Footer';

export default function Custom404() {
    return (
        <>
            <Head>
                <title>404 - Page Not Found</title>
            </Head>
            <NavBar />
            <main style={{ textAlign: 'center', padding: '50px 20px' }}>
                <h1>404 - Page Not Found</h1>
                <p>Sorry, the page or product you're looking for doesn't exist.</p>
                <Link href="/products" className="button">
                    Browse Our Products
                </Link>
            </main>
            <Footer />
        </>
    );
}