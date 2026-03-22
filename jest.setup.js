// eslint-disable-next-line no-undef
jest.mock("react-native-worklets", () =>
  require("react-native-worklets/src/mock"),
);
require("react-native-reanimated").setUpTests();
