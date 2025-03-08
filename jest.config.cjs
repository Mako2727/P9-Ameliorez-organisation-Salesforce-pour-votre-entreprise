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
   '^c/(.*)$': '<rootDir>/force-app/main/default/lwc/displaySumActivatedOrders/$1',
    '^lwc/(.*)$': '<rootDir>/force-app/main/default/lwc/$1',
}
};