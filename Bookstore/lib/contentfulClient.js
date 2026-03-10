// lib/contentful.js
import { createClient } from 'contentful';
import { createClient as createManagementClient } from 'contentful-management';

// Content Delivery API (CDA) - for reading published content
export const client = createClient({
  space: process.env.CONTENTFUL_SPACE_ID,
  accessToken: process.env.CONTENTFUL_ACCESS_TOKEN,
});

// Content Management API (CMA) - for creating/updating/deleting content
export function getManagementClient() {
  return createManagementClient({
    accessToken: process.env.CONTENTFUL_MANAGEMENT_TOKEN,
  });
}

// Helper: Get fresh sys.version for an entry (required for versioning)
export async function getFreshVersion(entryId) {
  try {
    const managementClient = getManagementClient();
    const space = await managementClient.getSpace(process.env.CONTENTFUL_SPACE_ID);
    const environment = await space.getEnvironment('master');
    const entry = await environment.getEntry(entryId);

    return entry.sys.version;
  } catch (error) {
    console.error('Error fetching fresh version:', error);
    return null;
  }
}

// Helper: Convert RichText to plain text (for reading)
function richTextToPlainText(richText) {
  if (!richText || typeof richText === 'string') {
    return richText || '';
  }

  if (richText.nodeType === 'document' && richText.content) {
    return richText.content
        .map(node => {
          if (node.nodeType === 'paragraph' && node.content) {
            return node.content
                .map(textNode => textNode.value || '')
                .join('');
          }
          return '';
        })
        .join('\n');
  }

  return '';
}

// Helper: Convert plain text to RichText format (for writing)
function textToRichText(text) {
  return {
    nodeType: 'document',
    data: {},
    content: [
      {
        nodeType: 'paragraph',
        data: {},
        content: [
          {
            nodeType: 'text',
            value: text,
            marks: [],
            data: {}
          }
        ]
      }
    ]
  };
}

// Helper: Fetch all published products
export async function getAllProducts() {
  try {
    const response = await client.getEntries({
      content_type: 'product',
      order: '-sys.createdAt',
    });

    return response.items.map(item => ({
      id: item.sys.id,
      title: item.fields.title,
      description: richTextToPlainText(item.fields.description),
      author: item.fields.author,
      category: item.fields.category || '',
      image: item.fields.image?.fields?.file?.url || null,
      price: item.fields.price || null,
      isbn: item.fields.isbn || null,
      createdAt: item.sys.createdAt,
      updatedAt: item.sys.updatedAt,
      version: item.sys.version,
    }));
  } catch (error) {
    console.error('Error fetching products:', error);
    return [];
  }
}

// Helper: Fetch a single product by ID
export async function getProductById(entryId) {
  try {
    const entry = await client.getEntry(entryId);

    return {
      id: entry.sys.id,
      title: entry.fields.title,
      description: richTextToPlainText(entry.fields.description),
      author: entry.fields.author,
      category: entry.fields.category || '',
      image: entry.fields.image?.fields?.file?.url || null,
      price: entry.fields.price || null,
      isbn: entry.fields.isbn || null,
      createdAt: entry.sys.createdAt,
      updatedAt: entry.sys.updatedAt,
      version: entry.sys.version,
    };
  } catch (error) {
    console.error('Error fetching product by ID:', error);
    if (error.sys?.id === 'NotFound') {
      return null;
    }
    throw error;
  }
}

// Helper: Update a product entry using CMA
export async function updateProduct(entryId, updates) {
  try {
    const managementClient = getManagementClient();
    const space = await managementClient.getSpace(process.env.CONTENTFUL_SPACE_ID);
    const environment = await space.getEnvironment('master');

    // Fetch fresh entry from Contentful (with latest sys.version)
    const entry = await environment.getEntry(entryId);

    // Update fields - only update if value is provided and not undefined
    if (updates.title !== undefined && updates.title !== null) {
      entry.fields.title = { 'en-US': updates.title };
    }
    if (updates.description !== undefined && updates.description !== null) {
      // Convert plain text to RichText format
      entry.fields.description = { 'en-US': textToRichText(updates.description) };
    }
    if (updates.category !== undefined && updates.category !== null && updates.category !== '') {
      entry.fields.category = { 'en-US': updates.category };
    }
    if (updates.isbn !== undefined && updates.isbn !== null && updates.isbn !== '') {
      entry.fields.isbn = { 'en-US': updates.isbn };
    }
    if (updates.price !== undefined && updates.price !== null) {
      entry.fields.price = { 'en-US': parseFloat(updates.price) };
    }

    // Save and publish
    const updatedEntry = await entry.update();
    const publishedEntry = await updatedEntry.publish();

    return {
      id: publishedEntry.sys.id,
      title: publishedEntry.fields.title['en-US'],
      description: richTextToPlainText(publishedEntry.fields.description['en-US']),
      author: publishedEntry.fields.author['en-US'],
      category: publishedEntry.fields.category?.['en-US'] || '',
      isbn: publishedEntry.fields.isbn?.['en-US'] || null,
      price: publishedEntry.fields.price?.['en-US'] || null,
      version: publishedEntry.sys.version,
    };
  } catch (error) {
    console.error('Detailed error updating product:', error);
    throw error;
  }
}

// Helper: Delete a product entry using CMA
export async function deleteProduct(entryId) {
  try {
    const managementClient = getManagementClient();
    const space = await managementClient.getSpace(process.env.CONTENTFUL_SPACE_ID);
    const environment = await space.getEnvironment('master');

    const entry = await environment.getEntry(entryId);

    // Unpublish first, then delete
    if (entry.isPublished()) {
      await entry.unpublish();
    }
    await entry.delete();

    return true;
  } catch (error) {
    console.error('Error deleting product:', error);
    throw error;
  }
}