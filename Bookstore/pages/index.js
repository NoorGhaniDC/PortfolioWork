import Head from 'next/head';
import Link from 'next/link';
import NavBar from '../components/NavBar';
import Footer from '../components/Footer';

export default function Home() {
  return (
    <>
      <Head>
        <title>The Bookstore</title>
        <meta name="description" content="Welcome to our online bookstore!" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <NavBar />

      <main>
        <div style={{ textAlign: 'center', padding: '50px 20px' }}>
          <h1>Welcome to The Bookstore</h1>
          <p>Your one-stop shop for the best books.</p>

          <Link href="/products" className="button" style={{ fontSize: '1.2rem', padding: '15px 30px' }}>
            Browse Our Collection
          </Link>
        </div>
      </main>

      <Footer />
    </>
  );
}