const noop = () => {};
const identity = (v) => v;

jest.mock("react-native-worklets", () => {
  const api = {
    __esModule: true,

    // Functions Reanimated may import during init/mock load
    runOnUISync: (fn) => fn,
    runOnUI: (fn) => fn,
    runOnUIAsync: async (fn) => fn,
    runOnJS: (fn) => fn,
    scheduleOnUI: noop,
    scheduleOnRN: noop,
    callMicrotasks: noop,
    executeOnUIRuntimeSync: (fn) => fn?.(),

    // Serializable/shareable APIs (your current error is here)
    createSerializable: identity,
    isSerializableRef: () => false,
    registerCustomSerializable: noop,
    createSynchronizable: identity,
    isSynchronizable: () => false,

    makeShareable: identity,
    makeShareableCloneRecursive: identity,
    makeShareableCloneOnUIRecursive: identity,
    isShareableRef: () => false,

    shareableMappingCache: new Map(),
    serializableMappingCache: new Map(),

    // Runtime/module placeholders
    WorkletsModule: {},
  };

  // Any extra named export access becomes a harmless no-op.
  return new Proxy(api, {
    get(target, prop) {
      return prop in target ? target[prop] : noop;
    },
  });
});

jest.mock("react-native-reanimated", () => {
  const Reanimated = require("react-native-reanimated/mock");
  Reanimated.default.call = () => {};
  return Reanimated;
});
