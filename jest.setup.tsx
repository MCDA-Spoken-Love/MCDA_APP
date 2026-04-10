import { QueryClient } from "@tanstack/query-core";

jest.mock("react-native-worklets", () =>
  require("react-native-worklets/src/mock"),
);
require("react-native-reanimated").setUpTests();

// Mock Keyboard API from react-native
jest.mock("react-native/Libraries/Components/Keyboard/Keyboard", () => ({
  __esModule: true,
  default: {
    addListener: jest.fn(() => ({
      remove: jest.fn(),
    })),
    removeListener: jest.fn(),
    removeAllListeners: jest.fn(),
    dismiss: jest.fn(),
  },
  addListener: jest.fn(() => ({
    remove: jest.fn(),
  })),
  removeListener: jest.fn(),
  removeAllListeners: jest.fn(),
  dismiss: jest.fn(),
}));

// Mock expo-router globally
jest.mock("expo-router", () => ({
  router: {
    navigate: jest.fn(),
    push: jest.fn(),
    replace: jest.fn(),
    back: jest.fn(),
  },
  useRouter: () => ({
    navigate: jest.fn(),
    push: jest.fn(),
    replace: jest.fn(),
    back: jest.fn(),
  }),
  useLocalSearchParams: () => ({}),
  useGlobalSearchParams: () => ({}),
  usePathname: () => "/",
  // @ts-ignore
  Link: ({ children }) => children,
  Redirect: () => null,
}));

// Mock storage globally
jest.mock("expo-secure-store", () => ({
  getItemAsync: jest.fn().mockResolvedValue(null),
  setItemAsync: jest.fn().mockResolvedValue(undefined),
  deleteItemAsync: jest.fn().mockResolvedValue(undefined),
}));

// Mock API client globally
jest.mock("./src/http/api-client", () => ({
  api: {
    post: jest.fn().mockResolvedValue({ data: {} }),
    get: jest.fn().mockResolvedValue({ data: {} }),
    patch: jest.fn().mockResolvedValue({ data: {} }),
    delete: jest.fn().mockResolvedValue({ data: {} }),
    put: jest.fn().mockResolvedValue({ data: {} }),
  },
  apiClient: jest.fn(() => ({
    post: jest.fn().mockResolvedValue({ data: {} }),
    get: jest.fn().mockResolvedValue({ data: {} }),
    patch: jest.fn().mockResolvedValue({ data: {} }),
    delete: jest.fn().mockResolvedValue({ data: {} }),
    put: jest.fn().mockResolvedValue({ data: {} }),
  })),
}));

// Mock cloudinary globally
jest.mock("./src/lib/cloudinary", () => ({
  presignedImageUpload: jest.fn().mockResolvedValue({
    secure_url: "https://mock-cloudinary-url.com/image.jpg",
  }),
}));

// Mock toast messages globally
jest.mock("react-native-toast-message", () => ({
  show: jest.fn(),
  hide: jest.fn(),
  __esModule: true,
  default: {
    show: jest.fn(),
    hide: jest.fn(),
  },
}));

// Mock @gorhom/bottom-sheet globally
jest.mock("@gorhom/bottom-sheet", () => {
  const React = require("react");
  const { View, TextInput } = require("react-native");

  // Create a mock component for BottomSheetTextInput with displayName
  const BottomSheetTextInput = React.forwardRef(
    ({ children, ...props }: any, ref: any) => (
      <TextInput {...props} ref={ref}>
        {children}
      </TextInput>
    ),
  );
  BottomSheetTextInput.displayName = "BottomSheetTextInput";

  return {
    __esModule: true,
    default: React.forwardRef(({ children, ...props }: any, ref: any) => (
      <View {...props} ref={ref}>
        {children}
      </View>
    )),
    BottomSheetView: ({ children, ...props }: any) => (
      <View {...props}>{children}</View>
    ),
    BottomSheetScrollView: ({ children, ...props }: any) => (
      <View {...props}>{children}</View>
    ),
    BottomSheetTextInput,
    BottomSheetBackdrop: () => null,
  };
});

// Mock fetch globally for any remaining fetch calls
// @ts-ignore
global.fetch = jest.fn(() =>
  Promise.resolve({
    ok: true,
    json: () => Promise.resolve({}),
    text: () => Promise.resolve(""),
    blob: () => Promise.resolve(new Blob()),
  }),
);

export let testQueryClient: QueryClient;

beforeEach(() => {
  testQueryClient = new QueryClient({
    defaultOptions: {
      queries: {
        retry: false,
        gcTime: 0,
      },
    },
  });
});

afterEach(() => {
  testQueryClient.clear();
});
