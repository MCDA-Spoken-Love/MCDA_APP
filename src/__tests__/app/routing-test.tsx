import { useAuth } from "@/features/auth";
import React from "react";
import { render, screen } from "@testing-library/react-native";
import Routing from "@/app/routing";

jest.mock("@/features/auth", () => ({
  useAuth: jest.fn(() => false),
}));

jest.mock("expo-router", () => {
  // eslint-disable-next-line @typescript-eslint/no-require-imports
  const React = require("react");
  // eslint-disable-next-line @typescript-eslint/no-require-imports
  const { Text } = require("react-native");

  const Stack = ({ children }: { children: React.ReactNode }) => (
    <>{children}</>
  );

  // eslint-disable-next-line react/display-name
  Stack.Screen = ({ name }: { name: string }) => (
    <Text testID={`screen-${name}`}>{name}</Text>
  );

  // eslint-disable-next-line react/display-name
  Stack.Protected = ({
    guard,
    children,
  }: {
    guard: boolean;
    children: React.ReactNode;
  }) => (guard ? <>{children}</> : null);

  return { Stack };
});

const mockUseAuth = useAuth as jest.MockedFunction<typeof useAuth>;

describe("<Routing/>", () => {
  test("redirects to welcome when user is not logged in", () => {
    mockUseAuth.mockReturnValue({ isLoggedIn: false });

    render(<Routing />);

    expect(screen.getByTestId("screen-welcome")).toBeTruthy();
    expect(screen.queryByTestId("screen-home")).toBeNull();
  });

  test("redirects to home when user is logged in", () => {
    mockUseAuth.mockReturnValue({ isLoggedIn: true });

    render(<Routing />);

    expect(screen.getByTestId("screen-home")).toBeTruthy();
    expect(screen.queryByTestId("screen-welcome")).toBeNull();
  });
});
