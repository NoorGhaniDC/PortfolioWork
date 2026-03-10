import { client } from '@/lib/contentfulClient';
import ProductList from '../../components/ProductList';
import NavBar from '../../components/NavBar';
import Footer from '../../components/Footer';
import { useState } from 'react';
import Head from 'next/head';

// Define how many products to show per page
const PRODUCTS_PER_PAGE = 3;


export async function getStaticProps() {
    try {
        const response = await client.getEntries({
            content_type: 'book',
            order: 'sys.createdAt',
            include: 2
        });

        return {
            props: {
                products: response.items,
                error: null,
            },
            revalidate: 60,
        };
    } catch (error) {
        console.error('Error fetching products:', error);
        return {
            props: {
                products: [],
                error: 'Failed to load products. Please try again later.',
            },
            revalidate: 60,
        };
    }
}

export default function ProductsPage({ products, error }) {
  const [currentPage, setCurrentPage] = useState(1);

  if (error) {
    return (
        <>
          <NavBar />
          <main>
            <h1>Error Loading Products</h1>
            <p>{error}</p>
          </main>
          <Footer />
        </>
    );
  }

  if (!products || products.length === 0) {
    return (
        <>
          <NavBar />
          <main>
            <h1>No Products Available</h1>
            <p>Please check back later or contact support.</p>
          </main>
          <Footer />
        </>
    );
  }

  // Pagination Logic
  const totalPages = Math.ceil(products.length / PRODUCTS_PER_PAGE);
  const startIndex = (currentPage - 1) * PRODUCTS_PER_PAGE;
  const endIndex = startIndex + PRODUCTS_PER_PAGE;
  const currentProducts = products.slice(startIndex, endIndex);

  return (
    <>
      <Head>
        <title>Our Products</title>
        <meta name="description" content="Browse our collection of products." />
      </Head>
      <NavBar />
      <main>
        <h1>Our Products</h1>
        <ProductList products={currentProducts} />

        {/* Pagination Controls */}
        <div className="pagination">
          <button
            onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
            disabled={currentPage === 1}
          >
            Previous
          </button>
          <span>
            Page {currentPage} of {totalPages}
          </span>
          <button
            onClick={() => setCurrentPage((prev) => Math.min(prev + 1, totalPages))}
            disabled={currentPage === totalPages}
          >
            Next
          </button>
        </div>
      </main>
      <Footer />
    </>
  );
}