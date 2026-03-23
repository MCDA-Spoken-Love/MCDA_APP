import React from "react";
import { act, render, screen, userEvent } from "@testing-library/react-native";
import { Text as RNText } from "react-native";

jest.mock("@/components/ui/text", () => {
  const React = require("react");
  const { Text } = require("react-native");

  return {
    Text: ({ children, ...props }: any) => <Text {...props}>{children}</Text>,
  };
});

jest.mock("@/components/ui/image", () => {
  const React = require("react");
  const { View } = require("react-native");

  return {
    Image: ({ alt }: { alt?: string }) => (
      <View testID={`image-${alt ?? "unknown"}`} />
    ),
  };
});

const { AuthOverlay } = require("@/features/auth/components/auth-overlay");

const advanceAnimation = (ms = 2000) => {
  act(() => {
    jest.advanceTimersByTime(ms);
  });
};

describe("<AuthOverlay />", () => {
  beforeEach(() => {
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.runOnlyPendingTimers();
    jest.useRealTimers();
  });

  it("renders static texts, images and children", () => {
    render(
      <AuthOverlay>
        <RNText testID="overlay-child">child content</RNText>
      </AuthOverlay>,
    );

    expect(screen.getByText("Boas vindas ao:")).toBeTruthy();
    expect(screen.getByText("M")).toBeTruthy();
    expect(screen.getByText("C")).toBeTruthy();
    expect(screen.getByText("D")).toBeTruthy();
    expect(screen.getByText("A")).toBeTruthy();

    expect(screen.getByTestId("image-logo")).toBeTruthy();
    expect(screen.getByTestId("image-hearts background")).toBeTruthy();
    expect(screen.getByTestId("overlay-child")).toBeTruthy();
  });

  it("keeps initial animated styles when triggerAnimation is false", () => {
    render(
      <AuthOverlay triggerAnimation={false}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const logoContainer = screen.getByTestId("logo-container");
    const textContainer = screen.getByTestId("text-container");

    expect(logoContainer).toHaveAnimatedStyle({
      width: 320,
      transform: [{ translateY: 0 }, { translateX: 0 }],
    });

    expect(textContainer).toHaveAnimatedStyle({
      transform: [{ translateY: 335.5 }, { translateX: -24.200000000000003 }],
    });
  });

  it("updates animated styles when triggerAnimation changes from false to true", () => {
    const { rerender } = render(
      <AuthOverlay triggerAnimation={false}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const logoContainer = screen.getByTestId("logo-container");
    const textContainer = screen.getByTestId("text-container");

    rerender(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    advanceAnimation();

    expect(logoContainer).toHaveAnimatedStyle({
      width: 180,
      transform: [{ translateY: -55.00000000000001 }, { translateX: 66 }],
    });

    expect(textContainer).toHaveAnimatedStyle({
      transform: [{ translateY: 82.5 }, { translateX: 41.800000000000004 }],
    });
  });

  it("applies animated styles on first render when triggerAnimation is true", () => {
    render(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const logoContainer = screen.getByTestId("logo-container");

    advanceAnimation();

    expect(logoContainer).toHaveAnimatedStyle({
      width: 180,
      transform: [{ translateY: -55.00000000000001 }, { translateX: 66 }],
    });
  });

  it("should NOT show the variant easter egg when text is NOT clicked 5 times", async () => {
    const user = userEvent.setup();

    render(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const textTouchableOpacity = screen.queryByTestId(
      "text-container-touchable",
    );

    await user.press(textTouchableOpacity);

    const textContent = screen.queryByTestId("text-container-content");
    expect(textContent).toHaveTextContent(
      "Boas vindas ao:MaisCarinho eDemonstrações deAfeto",
    );
  });

  it("should show the variant easter egg when text is  clicked 5 times", async () => {
    const user = userEvent.setup();

    render(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const textTouchableOpacity = screen.queryByTestId(
      "text-container-touchable",
    );

    await user.press(textTouchableOpacity);
    await user.press(textTouchableOpacity);
    await user.press(textTouchableOpacity);
    await user.press(textTouchableOpacity);
    await user.press(textTouchableOpacity);

    const textContent = screen.queryByTestId("text-container-content");

    expect(textContent).toHaveTextContent(
      "Boas vindas ao:MarinaCostaDeAlencar",
    );
  });

  it("keeps the same animated style when rerendered with triggerAnimation still true", () => {
    const { rerender } = render(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const logoContainer = screen.getByTestId("logo-container");

    advanceAnimation();

    expect(logoContainer).toHaveAnimatedStyle({
      width: 180,
      transform: [{ translateY: -55.00000000000001 }, { translateX: 66 }],
    });

    rerender(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    advanceAnimation(250);

    expect(logoContainer).toHaveAnimatedStyle({
      width: 180,
      transform: [{ translateY: -55.00000000000001 }, { translateX: 66 }],
    });
  });
});
