import Animated, { useAnimatedStyle, useSharedValue, withSpring } from "react-native-reanimated";
import { ReactNode, useEffect } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import { StyleSheet, View } from "react-native";
import { Image } from "@/components/ui/image";
import { Text } from "@/components/ui/text";

interface LayoutProps {
  children: ReactNode;
  triggerAnimation?: boolean;
}

export const AuthOverlay = ({
  children,
  triggerAnimation = false,
}: LayoutProps) => {
  const translateY = useSharedValue<number>(0);
  const translateX = useSharedValue<number>(0);
  const width = useSharedValue(320);
  const translateYText = useSharedValue<number>(305);
  const translateXText = useSharedValue<number>(-22);

  const animatedStylesText = useAnimatedStyle(() => ({
    transform: [
      {
        translateY: withSpring(translateYText.value * 1.1),
      },
      {
        translateX: withSpring(translateXText.value * 1.1),
      },
    ],
  }));

  const animatedStyles = useAnimatedStyle(() => ({
    transform: [
      {
        translateY: withSpring(translateY.value * 1.1),
      },
      {
        translateX: withSpring(translateX.value * 1.1),
      },
    ],
  }));

  useEffect(() => {
    if (triggerAnimation) {
      translateYText.value -= 230;
      translateXText.value += 60;
      translateY.value -= 50;
      translateX.value += 60;
      width.value = withSpring(180);
    }
  }, [
    triggerAnimation,
    translateY,
    translateX,
    width,
    translateYText,
    translateXText,
  ]);

  return (
    <SafeAreaView className={"flex-1 bg-primary"}>
      <View className="flex-1 flex-col">
        <View className={"relative h-1/2"}>
          <Animated.View
            style={[animatedStyles, { width, ...styles.container }]}
          >
            <Image
              className={"w-full aspect-video"}
              alt={"logo"}
              contentFit={"fill"}
              cachePolicy={"memory-disk"}
              source={require("@/assets/images/logo.svg")}
            />
          </Animated.View>
          <Image
            className={"flex-1 w-full h-full opacity-30"}
            alt={"hearts background"}
            contentFit="fill"
            loading={"eager"}
            cachePolicy={"memory-disk"}
            source={require("@/assets/images/hearts-bg.svg")}
          />
        </View>
        <Animated.View style={[animatedStylesText, styles.textContainer]}>
          <View className={"flex-col items-start gap-1 self-stretch"}>
            <Text className={"text-2xl self-start text-background font-coiny"}>
              Boas vindas ao:
            </Text>
            <Text className={"text-2xl text-background self-start font-coiny"}>
              <Text className={"text-3xl font-besty color-secondary"}>M</Text>
              ais
            </Text>
            <Text className={"text-2xl text-background self-start font-coiny"}>
              <Text className={"text-3xl font-besty color-secondary"}>C</Text>
              arinho e
            </Text>
            <Text className={"text-2xl text-background self-start font-coiny"}>
              <Text className={"text-3xl font-besty color-secondary"}>D</Text>
              emonstrações de
            </Text>
            <Text className={"text-2xl text-background self-start font-coiny"}>
              <Text className={"text-3xl font-besty color-secondary"}>A</Text>
              feto
            </Text>
          </View>
        </Animated.View>
        {children}
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: "center",
    position: "absolute",
    zIndex: 20,
    top: "25%",
    left: 50,
  },
  textContainer: {
    height: "50%",
    position: "absolute",
    alignItems: "center",
    top: "0%",
    left: 24,
    justifyContent: "space-evenly",
    paddingHorizontal: 24,
  },
});
