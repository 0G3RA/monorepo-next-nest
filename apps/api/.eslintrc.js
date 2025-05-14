module.exports = {
  "root": true,
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "tsconfig.json",
    "tsconfigRootDir": __dirname,
    "sourceType": "module"
  },
  "plugins": [
    "@typescript-eslint/eslint-plugin"
  ],
  "extends": [
    "plugin:@typescript-eslint/recommended",
    "plugin:prettier/recommended",
    "./node_modules/gts/"
  ],
  "env": {
    "node": true,
    "jest": true
  },
  "ignorePatterns": [
    ".eslintrc.js"
  ],
  "rules": {
    // * @typescript-eslint
    "@typescript-eslint/no-namespace": "off",
    "@typescript-eslint/no-explicit-any": "off",
    "@typescript-eslint/consistent-type-definitions": ["error","type"],
    "@typescript-eslint/consistent-type-imports": ["error",{"prefer":"no-type-imports"}],
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        "argsIgnorePattern": "^_",
        "varsIgnorePattern": "^_",
        "caughtErrorsIgnorePattern": "^_"
      }
    ],
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off"
  },
  "settings": {
    "node": {
      "allowModules": ["@nestjs/testing","supertest"]
    }
  }
};