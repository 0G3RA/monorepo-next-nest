module.exports = {
  "root": true,
  "extends": ["./node_modules/gts/", "next/core-web-vitals"],
  "rules": {
    // * @typescript-eslint
    "@typescript-eslint/no-namespace": "off",
    "@typescript-eslint/no-explicit-any": "off",
    "@typescript-eslint/consistent-type-definitions": ["error","type"],
    "@typescript-eslint/consistent-type-imports": ["error",{"fixStyle": "inline-type-imports"}],
    // * import
    "import/no-duplicates": "off",
    // * vanilla
    "prefer-arrow-callback": ["error",{"allowNamedFunctions": true}]
  },
  "settings": {
    "node": {
      "allowModules": [
        "@jest/types",
        "@testing-library/jest-dom",
        "@testing-library/react",
        "tailwindcss"
      ]
    }
  }
};