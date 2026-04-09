# Bookstore Application

A modern e-commerce bookstore built with Next.js, featuring JWT authentication, Contentful CMS integration, and a rich product catalog.

**Developers:** Noor Ghani, Buianto Sodnomov  
**Course:** INFT-3102  
**Academic Year:** Fall 2025  
**Institution:** Durham College


## Overview

This is a full-featured bookstore application built with [Next.js](https://nextjs.org). It integrates with the Contentful headless CMS for content management and implements JWT-based authentication for secure user sessions. The application provides a seamless shopping experience with product browsing, filtering, and user account management.

## Technology Stack

- **Frontend:** Next.js 16 with React 19
- **Authentication:** JWT (JSON Web Tokens) with bcryptjs
- **CMS:** Contentful (Headless CMS)
- **Styling:** CSS Modules
- **Build Tool:** Webpack, ESLint

## Features

- 🔐 **User Authentication:** JWT-based login/registration system
- 📚 **Product Catalog:** Browse and search books from Contentful
- 🎨 **Rich Product Details:** Dynamic product pages with detailed information
- 🔗 **Content Management:** Powered by Contentful API
- 📱 **Responsive Design:** Mobile-friendly interface
- 🛡️ **Secure Sessions:** Password hashing with bcryptjs
- ⚡ **Performance:** Next.js optimizations and fast page loads

## Project Structure

```
Bookstore/
├── components/             # Reusable React components
│   ├── NavBar.js          # Navigation component
│   ├── LoginForm.js       # User authentication form
│   ├── ProductList.js     # Product listing component
│   ├── ProductDetail.js   # Individual product details
│   ├── Footer.js          # Footer component
│   └── context/           # React Context providers
├── pages/                  # Next.js pages (file-based routing)
│   ├── index.js           # Home page
│   ├── about.js           # About page
│   ├── products/          # Product pages
│   ├── dashboard/         # User dashboard
│   ├── api/               # API routes
│   ├── _app.js            # App wrapper
│   ├── _document.js       # HTML document wrapper
│   └── 404.js             # Not found page
├── lib/                    # Utility functions
│   ├── auth.js            # Authentication logic
│   └── contentfulClient.js # Contentful API client
├── styles/                 # Global and module styles
│   ├── globals.css        # Global styles
│   ├── Home.module.css    # Home page styles
│   └── index.css          # Additional styles
├── public/                 # Static assets
├── package.json           # Dependencies and scripts
├── next.config.mjs        # Next.js configuration
└── eslint.config.mjs      # ESLint configuration
```

## Getting Started

### Prerequisites

- Node.js 18+ and npm/yarn/pnpm
- Contentful account and API credentials
- Environment variables configured

### Installation

1. Clone the repository
2. Install dependencies:
```bash
npm install
```

3. Set up environment variables in `.env.local`:
```
NEXT_PUBLIC_CONTENTFUL_SPACE_ID=your_space_id
NEXT_PUBLIC_CONTENTFUL_ACCESS_TOKEN=your_access_token
JWT_SECRET=your_secret_key
```

### Development

Start the development server:
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

### Build & Production

Build for production:
```bash
npm run build
npm start
```

### Linting

Run ESLint to check code quality:
```bash
npm run lint
```

## API Routes

- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `GET /api/products` - Fetch products from Contentful
- `GET /api/products/[id]` - Get product details

## Content Management

Products and content are managed through Contentful CMS. Visit the Contentful dashboard to:
- Add and manage books
- Update product details
- Manage categories and collections

## Deployment

### Deploy on Vercel (Recommended)

The easiest way to deploy is using [Vercel Platform](https://vercel.com):

1. Push code to GitHub/GitLab/Bitbucket
2. Connect repository to Vercel
3. Set environment variables in Vercel dashboard
4. Deploy with one click

See [Next.js Deployment Documentation](https://nextjs.org/docs/pages/building-your-application/deploying) for more details.

## Learn More

- [Next.js Documentation](https://nextjs.org/docs)
- [Contentful API Reference](https://www.contentful.com/developers/docs/)
- [JWT Authentication](https://jwt.io)

## License

Academic project - Created for Durham College coursework
