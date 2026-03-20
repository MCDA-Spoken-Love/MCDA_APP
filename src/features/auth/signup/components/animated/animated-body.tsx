import React, { useCallback, useEffect } from "react";
import { View } from "react-native";
import Animated, {
  useSharedValue,
  withDelay,
  withTiming,
} from "react-native-reanimated";
import { Button } from "@/components/ui/button";
import { Text } from "@/components/ui/text";

const DURATION = 1000;
const DELAY = 500;

export const AnimatedBody = () => {
  const opacity1 = useSharedValue<number>(0);
  const opacity2 = useSharedValue<number>(0);
  const opacity3 = useSharedValue<number>(0);

  const show = useCallback(() => {
    opacity1.value = withDelay(0, withTiming(1, { duration: DURATION }));
    opacity2.value = withDelay(DELAY, withTiming(1, { duration: DURATION }));
    opacity3.value = withDelay(
      2 * DELAY,
      withTiming(1, { duration: DURATION }),
    );
  }, [opacity1, opacity2, opacity3]);

  useEffect(() => {
    show();
  }, [show]);

  return (
    <View className={"h-1/2 flex-col justify-evenly px-6"}>
      <Animated.Text
        className="text-background font-coiny text-lg text-left"
        style={[{ opacity: opacity1 }]}
      >
        Esse aplicativo foi desenvolvido para facilitar a transmissão de um dos
        5 tipos de linguagens do amor: palavras de carinho.
      </Animated.Text>
      <Animated.Text
        className="text-background font-coiny text-lg text-left"
        style={[{ opacity: opacity2 }]}
      >
        Foi feito com amor e esperamos que você e seu parceiro gostem de usá-lo
        tanto quanto gostamos de criá-lo.
      </Animated.Text>
      <Animated.View style={[{ opacity: opacity3 }]}>
        <Button variant={"accent"} size={"full"}>
          <Text className="font-coiny">Avançar</Text>
        </Button>
      </Animated.View>
    </View>
  );
};
