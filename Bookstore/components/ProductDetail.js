import Image from 'next/image';
import { documentToReactComponents } from '@contentful/rich-text-react-renderer';

export default function ProductDetail({ product }) {
    const { title, description, author, image, price, isbn, category } = product.fields;

    return (
        <article className="product-detail">
            {/* LEFT COLUMN: Image */}
            <div className="product-image-container">
                {image?.fields?.file ? (
                    <Image
                        src={'https:' + image.fields.file.url}
                        width={400}
                        height={600}
                        alt={title}
                        priority
                        style={{ width: '100%', height: 'auto', objectFit: 'cover' }}
                    />
                ) : (
                    <div className="no-image-placeholder">
                        <p>No image available</p>
                    </div>
                )}
            </div>

            {/* RIGHT COLUMN: Content */}
            <div className="detail-content">
                {/* Category Label */}
                {category && <span className="category-pill">{category}</span>}
                
                <h1>{title}</h1>
                
                {author && <p className="author">By <strong>{author}</strong></p>}

                {/* Price */}
                {price && (
                    <div className="price-wrapper">
                        <span className="price">${price.toFixed(2)}</span>
                    </div>
                )}

                {/* Description Text */}
                <div className="description">
                    {description && documentToReactComponents(description)}
                </div>

                {/* Footer / Actions */}
                <div className="meta-footer">
                    {isbn && <p className="isbn">ISBN: {isbn}</p>}
                    <button className="button add-cart-btn">Add to Cart</button>
                </div>
            </div>
        </article>
    );
}