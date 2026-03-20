import { View } from "react-native";
import { Text } from "@/components/ui/text";

export default function Home() {
  return (
    <View testID={"screen-home"}>
      <Text className={"text-primary"}>User is logged in</Text>
    </View>
  );
}
