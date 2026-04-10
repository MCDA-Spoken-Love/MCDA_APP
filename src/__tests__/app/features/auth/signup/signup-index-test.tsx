import React from "react";
import { SignupPage } from "@/features/auth";
import {
  fireEvent,
  render,
  screen,
  waitFor,
} from "@testing-library/react-native";
import { wrapper } from "@/__tests__/test-utils";

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
});
