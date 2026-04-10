import { Pressable, Text } from "react-native";
import React from "react";
import { act, render, screen } from "@testing-library/react-native";
import { AnimatedBody } from "@/features/auth/signup/components/animated/animated-body";

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
    Button: (props: any) => <Pressable {...props} />,
  };
});

const advanceAnimation = (ms = 2000) => {
  act(() => {
    jest.advanceTimersByTime(ms);
  });
};

describe("<AnimatedBody />", () => {
  beforeEach(() => {
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.runOnlyPendingTimers();
    jest.useRealTimers();
  });

  it("Should render correctly with appropriate text", () => {
    render(
      <AnimatedBody
        onAdvance={function (): void {
          throw new Error("Function not implemented.");
        }}
      />,
    );

    expect(
      screen.getByText(
        "Esse aplicativo foi desenvolvido para facilitar a transmissão de um dos 5 tipos de linguagens do amor: palavras de carinho.",
      ),
    ).toBeTruthy();
    expect(
      screen.getByText(
        " Foi feito com amor e esperamos que você e seu parceiro gostem de usá-lo tanto quanto gostamos de criá-lo.",
      ),
    ).toBeTruthy();
    expect(screen.getByTestId("animated-body-button")).toBeTruthy();
  });

  it("should render animated text after animation delay", () => {
    render(
      <AnimatedBody
        onAdvance={function (): void {
          throw new Error("Function not implemented.");
        }}
      />,
    );

    const line1 = screen.getByText(
      "Esse aplicativo foi desenvolvido para facilitar a transmissão de um dos 5 tipos de linguagens do amor: palavras de carinho.",
    );
    const line2 = screen.getByText(
      " Foi feito com amor e esperamos que você e seu parceiro gostem de usá-lo tanto quanto gostamos de criá-lo.",
    );
    const button = screen.getByTestId("animated-body-button-view");

    expect(line1).toHaveAnimatedStyle({ opacity: 0 });
    expect(line2).toHaveAnimatedStyle({ opacity: 0 });
    expect(button).toHaveAnimatedStyle({ opacity: 0 });

    advanceAnimation();
    expect(line1).toHaveAnimatedStyle({ opacity: 1 });
    expect(line2).toHaveAnimatedStyle({ opacity: 1 });
    expect(button).toHaveAnimatedStyle({ opacity: 1 });
  });
});
