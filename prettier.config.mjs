/**
 * Prettier configuration for Go project auxiliary files
 * @see https://prettier.io/docs/en/configuration.html
 */
export default {
  // General settings
  printWidth: 120,
  tabWidth: 2,
  useTabs: false,
  semi: false,
  singleQuote: false,
  quoteProps: "as-needed",
  trailingComma: "es5",
  bracketSpacing: true,
  bracketSameLine: false,
  arrowParens: "always",
  endOfLine: "lf",

  // Markdown specific
  proseWrap: "always",

  // File-specific overrides
  overrides: [
    {
      files: ["*.md"],
      options: {
        proseWrap: "always",
        printWidth: 100,
      },
    },
    {
      files: ["*.yaml", "*.yml"],
      options: {
        singleQuote: false,
        bracketSpacing: true,
      },
    },
    {
      files: ["*.json"],
      options: {
        trailingComma: "none",
      },
    },
  ],
}
