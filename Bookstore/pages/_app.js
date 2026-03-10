import '../styles/index.css';
import { ProductProvider } from '@/components/context/ProductContext';
import { AuthProvider } from '@/components/context/AuthContext';

function MyApp({ Component, pageProps }) {
  return (
    <AuthProvider>
        <ProductProvider initialProducts={pageProps.products}>
            <Component {...pageProps} />
        </ProductProvider>
    </AuthProvider>
  );
}

export default MyApp;