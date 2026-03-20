import React from "react";
import { render, screen } from "@testing-library/react-native";
import { Text as RNText } from "react-native";

const mockSharedValues: { value: number }[] = [];
const mockWithSpring = jest.fn((toValue: number) => toValue);

jest.mock("react-native-reanimated", () => {
  const React = require("react");
  const { View } = require("react-native");

  return {
    __esModule: true,
    default: { View },

    useSharedValue: (initial: number) => {
      const ref = React.useRef(null as { value: number } | null);

      if (ref.current === null) {
        ref.current = { value: initial };
        mockSharedValues.push(ref.current);
      }

      return ref.current;
    },

    useAnimatedStyle: (worklet: () => unknown) => worklet(),

    withSpring: mockWithSpring,

    __getSharedValues: () => mockSharedValues,
    __resetSharedValues: () => {
      mockSharedValues.length = 0;
      mockWithSpring.mockClear();
    },
  };
});

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

// Require AFTER mocks so the component uses this mocked module instance.
const { AuthOverlay } = require("@/features/auth/components/auth-overlay");

const reanimatedMock = jest.requireMock("react-native-reanimated") as {
  withSpring: jest.Mock;
  __getSharedValues: () => { value: number }[];
  __resetSharedValues: () => void;
};

describe("<AuthOverlay />", () => {
  beforeEach(() => {
    reanimatedMock.__resetSharedValues();
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

  it("keeps initial shared values when triggerAnimation is false", () => {
    render(
      <AuthOverlay triggerAnimation={false}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const values = reanimatedMock.__getSharedValues().map((s) => s.value);

    expect(values).toEqual([0, 0, 320, 305, -22]);
    expect(reanimatedMock.withSpring).not.toHaveBeenCalledWith(180);
  });

  it("updates shared values when triggerAnimation changes from false to true", () => {
    const { rerender } = render(
      <AuthOverlay triggerAnimation={false}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    rerender(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const values = reanimatedMock.__getSharedValues().map((s) => s.value);

    expect(values).toEqual([-50, 60, 180, 75, 38]);
    expect(reanimatedMock.withSpring).toHaveBeenCalledWith(180);
  });

  it("applies animated values on first render when triggerAnimation is true", () => {
    render(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const values = reanimatedMock.__getSharedValues().map((s) => s.value);

    expect(values).toEqual([-50, 60, 180, 75, 38]);
    expect(reanimatedMock.withSpring).toHaveBeenCalledWith(180);
  });

  it("does not rerun the effect when rerendered with triggerAnimation still true", () => {
    const { rerender } = render(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const valuesBefore = reanimatedMock.__getSharedValues().map((s) => s.value);
    const count180Before = reanimatedMock.withSpring.mock.calls.filter(
      ([arg]) => arg === 180,
    ).length;

    rerender(
      <AuthOverlay triggerAnimation={true}>
        <RNText>child</RNText>
      </AuthOverlay>,
    );

    const valuesAfter = reanimatedMock.__getSharedValues().map((s) => s.value);
    const count180After = reanimatedMock.withSpring.mock.calls.filter(
      ([arg]) => arg === 180,
    ).length;

    expect(valuesAfter).toEqual(valuesBefore);
    expect(count180After).toBe(count180Before);
  });
});
