import { client } from '@/lib/contentfulClient';
import ProductDetail from '../../components/ProductDetail';
import NavBar from '../../components/NavBar';
import Footer from '../../components/Footer';
import Head from 'next/head';

function richTextToPlainText(richText) {
    if (!richText || !richText.content) return '';
    return richText.content
        .map(node => node.content?.map(c => c.value).join('') || '')
        .join(' ');
}

export async function getStaticPaths() {
    try {
        const response = await client.getEntries({ content_type: 'book' });

        const paths = response.items.map((item) => ({
            params: { id: item.sys.id },
        }));

        return {
            paths,
            fallback: 'blocking',
        };
    } catch (error) {
        console.error('Error fetching paths:', error);
        return {
            paths: [],
            fallback: 'blocking',
        };
    }
}

export async function getStaticProps({ params }) {
    try {
        const response = await client.getEntry(params.id, {
            include: 2
        });

        if (!response) {
            return { notFound: true };
        }

        return {
            props: {
                product: response,
                error: null,
            },
            revalidate: 60,
        };
    } catch (error) {
        console.error('Error fetching product:', error);
        return { notFound: true };
    }
}

export default function ProductDetailsPage({ product, error }) {
    // Error state
    if (error) {
        return (
            <>
                <Head>
                    <title>Error - Product Details</title>
                </Head>
                <NavBar />
                <main>
                    <h1>Error Loading Product</h1>
                    <p className="error-message">{error}</p>
                    <p>Please try again later or return to the products page.</p>
                </main>
                <Footer />
            </>
        );
    }

    // Loading state
    if (!product) {
        return (
            <>
                <NavBar />
                <main>
                    <div>Loading...</div>
                </main>
                <Footer />
            </>
        );
    }

    // Success state
    return (
        <>
            <Head>
                <title>{product.fields.title}</title>
                <meta
                    name="description"
                    content={
                        product.fields.description
                            ? richTextToPlainText(product.fields.description).substring(0, 150)
                            : `${product.fields.title} - Available at The Bookstore`
                    }
                />
            </Head>
            <NavBar />
            <main>
                <ProductDetail product={product} />
            </main>
            <Footer />
        </>
    );
}