import React from "react";
import { SignupPage } from "@/features/auth";
import {
  fireEvent,
  render,
  screen,
  userEvent,
  waitFor,
} from "@testing-library/react-native";
import { wrapper } from "@/__tests__/test-utils";
import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import * as ImagePicker from "expo-image-picker";
import { Pressable, View } from "react-native";

jest.mock("@/components/ui/icon", () => ({
  Icon: () => null,
}));

jest.mock("@/components/ui/select", () => {
  const React = require("react");
  const { View, Pressable } = require("react-native");

  const SelectContext = React.createContext(null);

  const Select = ({ children, onValueChange, value, ...props }: any) => (
    <SelectContext.Provider value={{ onValueChange, value }}>
      {/* Expose the string value (.value) on the View's props */}
      <View value={value?.value ?? value} {...props}>
        {children}
      </View>
    </SelectContext.Provider>
  );

  const SelectTrigger = ({ children, ...props }: any) => (
    <View {...props}>{children}</View>
  );

  const SelectContent = ({ children, ...props }: any) => (
    <View {...props}>{children}</View>
  );

  const SelectGroup = ({ children, ...props }: any) => (
    <View {...props}>{children}</View>
  );

  const SelectItem = ({ children, value, label, ...props }: any) => {
    const ctx = React.useContext(SelectContext);
    return (
      <Pressable
        onPress={() => ctx?.onValueChange?.({ value, label })}
        {...props}
      >
        {children}
      </Pressable>
    );
  };

  const SelectValue = ({ children, ...props }: any) => (
    <View {...props}>{children}</View>
  );

  return {
    Select,
    SelectTrigger,
    SelectContent,
    SelectGroup,
    SelectItem,
    SelectValue,
  };
});

jest.mock("@/features/auth/components/auth-overlay", () => ({
  AuthOverlay: ({ children }: { children: React.ReactNode }) => <>{children}</>,
}));

jest.mock("@/components/ui/text", () => {
  const React = require("react");
  const { Text } = require("react-native");

  return {
    Text: ({ children, ...props }: any) => <Text {...props}>{children}</Text>,
  };
});

jest.mock("@/components/ui/button", () => {
  const React = require("react");
  const { Pressable } = require("react-native");

  return {
    Button: ({ children, onPress, ...props }: any) => (
      <Pressable onPress={onPress} {...props}>
        {children}
      </Pressable>
    ),
  };
});

jest.mock("@/components/ui/image", () => {
  const React = require("react");
  const { View } = require("react-native");

  return {
    Image: ({ testID, source, alt, ...props }: any) => (
      <View
        testID={testID ?? `image-${alt ?? "unknown"}`}
        source={source}
        alt={alt}
        {...props}
      />
    ),
  };
});

jest.mock("@/components/ui/checkbox", () => {
  const { TouchableOpacity, View } = require("react-native");

  return {
    Checkbox: ({ testID, checked, onCheckedChange, ...props }: any) => (
      <TouchableOpacity
        testID={testID ?? "mock-checkbox"}
        accessibilityState={{ checked: !!checked }}
        onPress={() => onCheckedChange?.(!checked)}
        {...props}
      >
        <View />
      </TouchableOpacity>
    ),
  };
});

const mockSelectedImage = {
  canceled: false,
  assets: [{ uri: "mock-uri://photo.jpg", width: 100, height: 100 }],
};

const mockedLaunchImageLibrary =
  ImagePicker.launchImageLibraryAsync as jest.MockedFunction<
    typeof ImagePicker.launchImageLibraryAsync
  >;

jest.mock("expo-image-picker", () => ({
  ...jest.requireActual("expo-image-picker"),
  launchImageLibraryAsync: jest.fn(),
  launchCameraAsync: jest.fn(),
  requestMediaLibraryPermissionsAsync: jest.fn().mockResolvedValue({
    status: "granted",
    granted: true,
    canAskAgain: true,
    expires: "never",
  }),
  requestCameraPermissionsAsync: jest.fn().mockResolvedValue({
    status: "granted",
    granted: true,
    canAskAgain: true,
    expires: "never",
  }),
}));

jest.mock("expo-camera", () => ({
  ...jest.requireActual("expo-camera"),
  useCameraPermissions: () => [
    { granted: true, status: "granted", canAskAgain: true, expires: "never" },
    jest.fn(), // mock da função requestPermission
  ],
}));

const mockSignupValues: SignupSchemaType = {
  first_name: "John",
  last_name: "Doe",
  username: "jorginho",
  sexuality: "OTHER",
  gender: "OTHER",
  profile_picture: "mock-uri://photo.jpg",
  email: "johndoe@gmail.com",
  password1: "johndoe123@",
  password2: "johndoes123@",
  has_accepted_privacy_policy: true,
  has_accepted_terms_and_conditions: true,
};

describe("Signup Feature integration Test", () => {
  it("should initially render the AnimatedBody component", () => {
    render(<SignupPage />, { wrapper });

    expect(screen.getByTestId("animated-body")).toBeTruthy();
    expect(screen.queryByTestId("signup-form")).not.toBeTruthy();
  });

  it("should render the signup form when the animated body button is clicked", async () => {
    render(<SignupPage />, { wrapper });

    const button = screen.getByTestId("animated-body-button");

    expect(screen.queryByTestId("signup-form")).not.toBeTruthy();

    fireEvent.press(button);

    await waitFor(
      () => {
        expect(screen.getByTestId("signup-form")).toBeTruthy();
      },
      { timeout: 3000 },
    );

    expect(screen.queryByTestId("animated-body")).not.toBeTruthy();
  });

  it("should properly submit the form in the happy case", async () => {
    const user = userEvent.setup();
    render(<SignupPage />, { wrapper });
    const button = screen.getByTestId("animated-body-button");

    expect(screen.queryByTestId("signup-form")).not.toBeTruthy();

    fireEvent.press(button);

    await waitFor(
      () => {
        expect(screen.getByTestId("signup-form")).toBeTruthy();
      },
      { timeout: 3000 },
    );

    expect(screen.queryByTestId("animated-body")).not.toBeTruthy();

    expect(screen.getByTestId("name-and-user-step")).toBeTruthy();

    const firstNameInput = screen.getByTestId("first-name-input");

    await user.type(firstNameInput, mockSignupValues.first_name);
    expect(firstNameInput.props.value).toBe(mockSignupValues.first_name);

    const lastNameInput = screen.getByTestId("last-name-input");
    await user.type(lastNameInput, mockSignupValues.last_name);
    expect(lastNameInput.props.value).toBe(mockSignupValues.last_name);

    const usernameInput = screen.getByTestId("username-input");
    await user.type(usernameInput, mockSignupValues.username);
    expect(usernameInput.props.value).toBe(mockSignupValues.username);

    const step1NextButton = screen.getByTestId("advance-input");
    fireEvent.press(step1NextButton);

    await waitFor(
      () => {
        expect(screen.queryByTestId("gender-and-sexuality-step")).toBeTruthy();
      },
      { timeout: 3000 },
    );

    const genderInput = screen.queryByTestId("gender-input");
    await user.press(genderInput);
    const genderOption = await screen.findByTestId(`gender-option-OTHER`);
    await user.press(genderOption);
    expect(genderInput?.props.value).toBe(mockSignupValues.gender);

    const sexualityInput = screen.queryByTestId("sexuality-input");
    await user.press(sexualityInput);
    const sexualityOption = await screen.findByTestId(`sexuality-option-OTHER`);
    await user.press(sexualityOption);
    expect(sexualityInput?.props.value).toBe(mockSignupValues.sexuality);

    const step2NextButton = screen.getByTestId("advance-input");
    fireEvent.press(step2NextButton);

    await waitFor(
      () => {
        expect(
          screen.queryByTestId("profile-pic-step-after-permission"),
        ).toBeTruthy();
      },
      { timeout: 3000 },
    );

    mockedLaunchImageLibrary.mockResolvedValue(mockSelectedImage as any);

    const pickButton = screen.queryByTestId("pick-image-button");

    await user.press(pickButton);

    await waitFor(() => {
      const selectedImageInput = screen.getByTestId("chosen-profile-picture");
      expect(selectedImageInput.props.source.uri).toBe(
        mockSignupValues.profile_picture,
      );
    });

    const step3NextButton = screen.getByTestId("advance-input");
    fireEvent.press(step3NextButton);

    await waitFor(
      () => {
        expect(screen.queryByTestId("mail-and-password-step")).toBeTruthy();
      },
      { timeout: 3000 },
    );

    const emailInput = screen.getByTestId("email-input");

    await user.type(emailInput, mockSignupValues.email);
    expect(emailInput.props.value).toBe(mockSignupValues.email);

    const password1Input = screen.getByTestId("password1-input");
    await user.type(password1Input, mockSignupValues.password1);
    expect(password1Input.props.value).toBe(mockSignupValues.password1);

    const password2Input = screen.getByTestId("password2-input");
    await user.type(password2Input, mockSignupValues.password2);
    expect(password2Input.props.value).toBe(mockSignupValues.password2);

    const termsAndConditionsCheckbox = screen.getByTestId(
      "terms-and-conditions-checkbox",
    );
    await user.press(termsAndConditionsCheckbox);
    expect(termsAndConditionsCheckbox.props.accessibilityState.checked).toBe(
      true,
    );

    const privacyPolicyCheckbox = screen.getByTestId("privacy-policy-checkbox");
    await user.press(privacyPolicyCheckbox);
    expect(privacyPolicyCheckbox.props.accessibilityState.checked).toBe(true);
  });
});
