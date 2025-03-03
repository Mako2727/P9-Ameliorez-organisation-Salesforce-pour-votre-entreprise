module.exports = {
  preset: '@lwc/jest-preset',
  moduleNameMapper: {
      '^(c)/(.+)$': '<rootDir>/force-app/main/default/lwc/$2/$2'
  },
  testPathIgnorePatterns: [
      '<rootDir>/node_modules/',
      '<rootDir>/test/specs/'
  ],
  moduleNameMapper: {
    '^@salesforce/apex/(.*)$': '<rootDir>/force-app/main/default/lwc/__mocks__/$1',
   // '^lightning/uiRecordApi$': '<rootDir>/force-app/main/default/lwc/__mocks__/lightning/uiRecordApi.js',
   '^c/(.*)$': '<rootDir>/force-app/main/default/lwc/orders/$1',
    '^lwc/(.*)$': '<rootDir>/force-app/main/default/lwc/$1',
    //  '^lightning/(.*)$': '<rootDir>/node_modules/lightning'
}
};