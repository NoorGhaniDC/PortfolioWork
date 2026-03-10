import Link from 'next/link';
import Image from 'next/image';
import { useAuth } from './context/AuthContext';
import { useRouter } from 'next/router';

export default function ProductList({ products, onDelete }) {
  const { user } = useAuth();
  const router = useRouter();

  if (!products || products.length === 0) {
    return <p>No products found.</p>;
  }

  const handleEdit = (productId) => {
    void router.push(`/dashboard/edit/${productId}`);
  };

  const handleDelete = async (productId) => {
    if (!confirm('Are you sure you want to delete this product?')) {
      return;
    }

    try {
      const res = await fetch(`/api/posts/${productId}`, {
        method: 'DELETE'
      });

      if (res.ok) {
        // Call the parent's onDelete callback to refresh the list
        if (onDelete) {
          onDelete(productId);
        }
      } else {
        const data = await res.json();
        alert(data.message || 'Failed to delete product');
      }
    } catch (err) {
      alert('An error occurred while deleting the product');
    }
  };

  // RBAC: Check if user can edit a product (owner or admin)
  const canEdit = (product) => {
    if (!user) return false;
    // Admins can edit any product
    if (user.role === 'admin') return true;
    // Authors can only edit their own products
    if (user.role === 'author' && product.fields.author === user.email) return true;
    return false;
  };

  // RBAC: Admin or owner can delete
  const canDelete = (product) => {
    if (!user) return false;
    // Admins can delete any product
    if (user.role === 'admin') return true;
    // Authors can delete their own products
    if (user.role === 'author' && product.fields.author === user.email) return true;
    return false;
  };

  return (
      <div className="product-grid">
        {products.map((product) => (
            <div key={product.sys.id} className="card">
              {product.fields.image?.fields?.file && (
                  <div className="product-image-container">
                    <Link href={`/products/${product.sys.id}`}>
                      <Image
                          src={'https:' + product.fields.image.fields.file.url}
                          width={150}
                          height={300}
                          style={{ objectFit: 'cover' }}
                          alt={product.fields.title}
                      />
                    </Link>
                  </div>
              )}
              <h2>{product.fields.title}</h2>
              {product.fields.author && <p>By: {product.fields.author}</p>}
              {product.fields.price && <p className="price">${product.fields.price.toFixed(2)}</p>}

              <Link href={`/products/${product.sys.id}`} className="button">
                View Details
              </Link>

              {/* RBAC: Show edit/delete buttons based on permissions */}
              {(canEdit(product) || canDelete(product)) && (
                  <div style={{ marginTop: '10px', display: 'flex', gap: '10px', justifyContent: 'center' }}>
                    {/* Only owner or admin sees Edit button */}
                    {canEdit(product) && (
                        <button
                            onClick={() => handleEdit(product.sys.id)}
                            className="button"
                            style={{
                              backgroundColor: '#0070f3',
                              color: 'white',
                              padding: '8px 16px',
                              fontSize: '14px'
                            }}
                        >
                          Edit
                        </button>
                    )}

                    {/* Owner or admin sees Delete button */}
                    {canDelete(product) && (
                        <button
                            onClick={() => void handleDelete(product.sys.id)}
                            className="button"
                            style={{
                              backgroundColor: '#dc3545',
                              color: 'white',
                              padding: '8px 16px',
                              fontSize: '14px'
                            }}
                        >
                          Delete
                        </button>
                    )}
                  </div>
              )}
            </div>
        ))}
      </div>
  );
}