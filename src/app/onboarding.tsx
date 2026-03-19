import { View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Image } from "@/components/ui/image";
import { Text } from "@/components/ui/text";
import { Button } from "@/components/ui/button";

export default function Onboarding() {
  return (
    <SafeAreaView className={"flex-1 bg-primary"}>
      <View className="flex-1 flex-col">
        <View className={"relative h-1/2"}>
          <View
            className={
              "absolute top-1/4 left-1/2 w-80 z-20 -translate-x-1/2 items-center justify-center "
            }
          >
            <Image
              className={"w-full aspect-video"}
              alt={"logo"}
              contentFit={"fill"}
              source={require("../../assets/images/logo.svg")}
              transition={1000}
            />
          </View>
          <Image
            className={"flex-1 w-full h-full opacity-45"}
            alt={"hearts background"}
            source={require("../../assets/images/hearts-bg.svg")}
            contentFit="cover"
            transition={1000}
          />
        </View>
        <View className={"h-1/2 flex-col items-center justify-evenly px-6"}>
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
          <View className={"flex-col items-center gap-4 self-stretch"}>
            <Button variant={"accent"} size={"full"}>
              <Text className="font-coiny">Login</Text>
            </Button>
            <Button variant={"ghost"} size={"full"}>
              <Text className="font-coiny">Criar conta</Text>
            </Button>
          </View>
        </View>
      </View>
    </SafeAreaView>
  );
}
