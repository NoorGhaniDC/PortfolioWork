import { verifyToken } from '@/lib/auth';
import { getProductById, updateProduct, deleteProduct, getFreshVersion } from '@/lib/contentfulClient';

// Middleware: Require authentication
function requireAuth(req) {
    const token = req.cookies.token;

    if (!token) {
        return { authenticated: false, error: 'No token provided' };
    }

    const payload = verifyToken(token);

    if (!payload) {
        return { authenticated: false, error: 'Invalid or expired token' };
    }

    return { authenticated: true, user: payload };
}

export default async function handler(req, res) {
    const { id } = req.query;

    // GET: Retrieve a single product (public)
    if (req.method === 'GET') {
        try {
            const product = await getProductById(id);

            if (!product) {
                return res.status(404).json({ message: 'Product not found' });
            }

            return res.status(200).json({ post: product });
        } catch (error) {
            console.error('Error fetching product:', error);
            return res.status(500).json({ message: 'Error fetching product' });
        }
    }

    // PUT: Update a product
    if (req.method === 'PUT') {
        const auth = requireAuth(req);

        if (!auth.authenticated) {
            return res.status(401).json({ message: auth.error });
        }

        try {
            const product = await getProductById(id);

            if (!product) {
                return res.status(404).json({ message: 'Product not found' });
            }

            const canEdit = auth.user.role === 'admin' ||
                (auth.user.role === 'author' && product.author === auth.user.email);

            if (!canEdit) {
                return res.status(403).json({ message: 'Forbidden: You do not have permission to edit this product' });
            }

            const { title, description, category, isbn, price, version: clientVersion } = req.body;

            const freshVersion = await getFreshVersion(id);

            if (!freshVersion) {
                return res.status(500).json({ message: 'Error fetching latest version from Contentful' });
            }

            if (clientVersion !== undefined && clientVersion !== freshVersion) {
                return res.status(409).json({
                    message: 'Conflict: Product has been modified by another user',
                    currentVersion: freshVersion,
                    conflict: true
                });
            }

            const updatedProduct = await updateProduct(id, {
                title,
                description,
                category,
                isbn,
                price
            });

            return res.status(200).json({
                message: 'Product updated successfully',
                post: updatedProduct
            });
        } catch (error) {
            console.error('Error updating product:', error);
            return res.status(500).json({ message: 'Error updating product in Contentful' });
        }
    }

    // DELETE: Remove a product
    if (req.method === 'DELETE') {
        const auth = requireAuth(req);

        if (!auth.authenticated) {
            return res.status(401).json({ message: auth.error });
        }

        try {
            const product = await getProductById(id);

            if (!product) {
                return res.status(404).json({ message: 'Product not found' });
            }

            // RBAC: Admin or owner can delete
            const canDelete = auth.user.role === 'admin' ||
                (auth.user.role === 'author' && product.author === auth.user.email);

            if (!canDelete) {
                return res.status(403).json({ message: 'Forbidden: You can only delete your own products' });
            }

            await deleteProduct(id);

            return res.status(200).json({
                message: 'Product deleted successfully',
                deletedId: id
            });
        } catch (error) {
            console.error('Error deleting product:', error);
            return res.status(500).json({ message: 'Error deleting product from Contentful' });
        }
    }

    return res.status(405).json({ message: 'Method not allowed' });
}