module.exports = {
    preset: '@salesforce/sfdx-lwc-jest',
    testEnvironment: 'jest-environment-node',
    moduleFileExtensions: ['js', 'json', 'vue', 'html'],
    transform: {
      '^.+\\.(js|ts|html)$': 'babel-jest',
    },
  };