import js from "@eslint/js"
import eslintConfigPrettier from "eslint-config-prettier"
import markdown from "eslint-plugin-markdown"
import yml from "eslint-plugin-yml"
import jsonc from "eslint-plugin-jsonc"
import globals from "globals"

/**
 * ESLint configuration for Go project auxiliary files
 * @see https://eslint.org/docs/latest/use/configure/
 */
export default [
  // Ignore patterns
  {
    ignores: [
      "node_modules/**",
      "bin/**",
      "dist/**",
      "vendor/**",
      "coverage/**",
      ".git/**",
      "*.go",
    ],
  },

  // JavaScript files (if any scripts exist)
  {
    files: ["**/*.js", "**/*.mjs"],
    ...js.configs.recommended,
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        ...globals.node,
      },
    },
    rules: {
      "no-unused-vars": ["error", { argsIgnorePattern: "^_" }],
      "no-console": "off",
    },
  },

  // YAML files
  ...yml.configs["flat/recommended"],
  ...yml.configs["flat/prettier"],
  {
    files: ["**/*.yaml", "**/*.yml"],
    rules: {
      "yml/no-empty-document": "error",
      "yml/require-string-key": "error",
    },
  },

  // JSON files
  ...jsonc.configs["flat/recommended-with-json"],
  ...jsonc.configs["flat/prettier"],
  {
    files: ["**/*.json"],
    rules: {
      "jsonc/sort-keys": "off",
    },
  },

  // Markdown files
  ...markdown.configs.recommended,

  // Prettier compatibility (must be last)
  eslintConfigPrettier,
]
