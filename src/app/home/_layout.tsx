import { View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import Home from "@/app/home/index";

export default function HomeLayout() {
  return (
    <SafeAreaView style={{ flex: 1 }} datatest-id={"screen-home"}>
      <View style={{ flex: 1 }}>
        <Home />
      </View>
    </SafeAreaView>
  );
}
