module.exports = {
  moduleFileExtensions: ["js", "html", "json", "mjs"], // Extensions supportées
  testEnvironment: "jsdom", // Simuler un navigateur
  transform: {
    "^.+\\.(js|jsx|mjs|ts|tsx)$": "babel-jest", // Utiliser babel-jest pour les fichiers js et jsx
    "^.+\\.html$": "html-loader-jest" // Support pour les fichiers HTML
  },
  moduleNameMapper: {
    "^c/(.*)": "<rootDir>/force-app/main/default/lwc/$1/$1.js" // Pour résoudre correctement les imports Lightning Web Component (LWC)
  },
  preset: "@salesforce/sfdx-lwc-jest", // Utilise le preset spécifique à LWC de Salesforce
  setupFilesAfterEnv: ["@salesforce/sfdx-lwc-jest/setup"] // Setup pour Jest avec LWC
};
