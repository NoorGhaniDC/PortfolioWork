import { createContext, useContext, useState } from 'react';

const ProductContext = createContext();

export function ProductProvider({ children, initialProducts = [] }) {
  const [products] = useState(initialProducts);

  return (
    <ProductContext.Provider value={{ products }}>
      {children}
    </ProductContext.Provider>
  );
}

export function useProducts() {
  return useContext(ProductContext);
}