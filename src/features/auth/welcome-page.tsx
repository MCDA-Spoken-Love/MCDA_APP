import { View } from "react-native";
import { Text } from "@/components/ui/text";
import { Button } from "@/components/ui/button";
import { router } from "expo-router";
import { Href } from "expo-router/build/types";

export function WelcomePage() {
  const handlePressIn = (screen: Href) => {
    router.prefetch(screen);
  };

  const handleNavigate = (screen: Href) => {
    return router.push(screen);
  };

  return (
    <View
      className={"h-1/2 flex-col items-end  justify-end px-6"}
      testID={"screen-welcome"}
    >
      <View className={"flex-col items-center gap-6 self-stretch"}>
        <Button
          variant={"accent"}
          size={"full"}
          onPressIn={() => handlePressIn("/signin")}
          onPress={() => handleNavigate("/signin")}
        >
          <Text className="font-coiny">Login</Text>
        </Button>
        <Button
          variant={"ghost"}
          size={"full"}
          onPressIn={() => handlePressIn("/signup")}
          onPress={() => handleNavigate("/signup")}
        >
          <Text className="font-coiny">Criar conta</Text>
        </Button>
      </View>
    </View>
  );
}
