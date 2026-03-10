import { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import { useAuth } from '@/components/context/AuthContext';
import NavBar from '../../../components/NavBar';
import Footer from '../../../components/Footer';

export default function EditPost() {
    const { user, loading } = useAuth();
    const router = useRouter();
    const { id } = router.query;

    const [post, setPost] = useState(null);
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [author, setAuthor] = useState('');
    const [category, setCategory] = useState('');
    const [isbn, setIsbn] = useState('');
    const [price, setPrice] = useState('');
    const [error, setError] = useState('');
    const [saving, setSaving] = useState(false);
    const [loadingPost, setLoadingPost] = useState(true);

    // RBAC: Protect route - must be logged in as admin or author
    useEffect(() => {
        if (!loading && (!user || (user.role !== 'admin' && user.role !== 'author'))) {
            void router.push('/');
        }
    }, [user, loading, router]);

    // Fetch the post to edit
    useEffect(() => {
        if (!id || !user) return;

        fetch(`/api/posts/${id}`)
            .then(res => {
                if (!res.ok) throw new Error('Post not found');
                return res.json();
            })
            .then(data => {
                setPost(data.post);
                setTitle(data.post.title);
                setDescription(data.post.description || '');
                setAuthor(data.post.author);
                setCategory(data.post.category || '');
                setIsbn(data.post.isbn || '');
                setPrice(data.post.price || '');
                setLoadingPost(false);

                // RBAC: Authors can only edit their own posts
                if (user.role === 'author' && data.post.author !== user.email) {
                    setError('You can only edit your own posts');
                }
            })
            .catch(err => {
                setError(err.message);
                setLoadingPost(false);
            });
    }, [id, user]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');

        // RBAC: Block authors from editing others' posts
        if (user.role === 'author' && post.author !== user.email) {
            setError('You can only edit your own posts');
            return;
        }

        setSaving(true);

        try {
            const res = await fetch(`/api/posts/${id}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    title,
                    description,
                    category,
                    isbn,
                    price: price ? parseFloat(price) : null,
                    version: post.version // For fresh versioning
                })
            });

            const data = await res.json();

            if (res.ok) {
                // Redirect to /products instead of /dashboard
                await router.push('/products');
            } else {
                setError(data.message || 'Failed to update post');
            }
        } catch (err) {
            setError('An error occurred while saving');
        } finally {
            setSaving(false);
        }
    };

    // Show loading while checking auth
    if (loading) return <p>Loading...</p>;

    // If no user, return null (redirect will happen)
    if (!user) return null;

    // Show loading while fetching post
    if (loadingPost) {
        return (
            <>
                <NavBar />
                <main style={{ padding: '20px' }}>
                    <p>Loading post...</p>
                </main>
                <Footer />
            </>
        );
    }

    // Show error if post couldn't be loaded or user lacks permission
    if (error && !post) {
        return (
            <>
                <NavBar />
                <main style={{ padding: '20px' }}>
                    <h1>Edit Post</h1>
                    <p style={{ color: 'red' }}>{error}</p>
                    <button onClick={() => void router.push('/products')}>Back to Products</button>
                </main>
                <Footer />
            </>
        );
    }

    // Check if user can edit (admins can edit anything, authors only their own)
    const canEdit = user.role === 'admin' || (user.role === 'author' && post.author === user.email);

    return (
        <>
            <NavBar />
            <main style={{ padding: '20px', maxWidth: '800px', margin: '0 auto' }}>
                <h1>Edit Product</h1>

                {!canEdit ? (
                    <>
                        <p style={{ color: 'red' }}>You don&apos;t have permission to edit this product.</p>
                        <button onClick={() => void router.push('/products')}>Back to Products</button>
                    </>
                ) : (
                    <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '15px' }}>
                        <div>
                            <label htmlFor="title" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold' }}>
                                Title
                            </label>
                            <input
                                id="title"
                                type="text"
                                value={title}
                                onChange={(e) => setTitle(e.target.value)}
                                required
                                style={{ width: '100%', padding: '8px', fontSize: '16px' }}
                            />
                        </div>

                        <div>
                            <label htmlFor="description" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold' }}>
                                Description
                            </label>
                            <textarea
                                id="description"
                                value={description}
                                onChange={(e) => setDescription(e.target.value)}
                                required
                                rows="10"
                                style={{ width: '100%', padding: '8px', fontSize: '16px' }}
                            />
                        </div>

                        <div>
                            <label htmlFor="author" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold' }}>
                                Author (read-only)
                            </label>
                            <input
                                id="author"
                                type="text"
                                value={author}
                                readOnly
                                disabled
                                style={{ width: '100%', padding: '8px', fontSize: '16px', backgroundColor: '#f5f5f5', cursor: 'not-allowed' }}
                            />
                        </div>

                        <div>
                            <label htmlFor="category" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold' }}>
                                Category
                            </label>
                            <input
                                id="category"
                                type="text"
                                value={category}
                                onChange={(e) => setCategory(e.target.value)}
                                style={{ width: '100%', padding: '8px', fontSize: '16px' }}
                            />
                        </div>

                        <div>
                            <label htmlFor="isbn" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold' }}>
                                ISBN
                            </label>
                            <input
                                id="isbn"
                                type="text"
                                value={isbn}
                                onChange={(e) => setIsbn(e.target.value)}
                                style={{ width: '100%', padding: '8px', fontSize: '16px' }}
                            />
                        </div>

                        <div>
                            <label htmlFor="price" style={{ display: 'block', marginBottom: '5px', fontWeight: 'bold' }}>
                                Price
                            </label>
                            <input
                                id="price"
                                type="number"
                                step="0.01"
                                min="0"
                                value={price}
                                onChange={(e) => setPrice(e.target.value)}
                                style={{ width: '100%', padding: '8px', fontSize: '16px' }}
                            />
                        </div>

                        {error && <p style={{ color: 'red' }}>{error}</p>}

                        <div style={{ display: 'flex', gap: '10px' }}>
                            <button type="submit" disabled={saving}>
                                {saving ? 'Saving...' : 'Save Changes'}
                            </button>
                            <button type="button" onClick={() => void router.push('/products')}>
                                Cancel
                            </button>
                        </div>
                    </form>
                )}
            </main>
            <Footer />
        </>
    );
}