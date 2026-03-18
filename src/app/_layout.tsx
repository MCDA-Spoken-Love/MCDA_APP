import "../global.css";
import { ThemeProvider } from "@react-navigation/native";
import { PortalHost } from "@rn-primitives/portal";
import { NAV_THEME } from "@/lib/theme";
import { useColorScheme } from "@/hooks/use-color-scheme";
import { Button } from "@/components/ui/button";
import { Text } from "@/components/ui/text";
import * as SplashScreen from "expo-splash-screen";

SplashScreen.setOptions({
  duration: 1000,
  fade: true,
});

export default function RootLayout() {
  const colorScheme = useColorScheme();
  const resolvedColorScheme = colorScheme === "dark" ? "dark" : "light";

  return (
    <ThemeProvider value={NAV_THEME[resolvedColorScheme]}>
      <Button className={"mt-60"} onPress={() => alert("pressed")}>
        <Text>aaaa</Text>
      </Button>
      <PortalHost />
    </ThemeProvider>
  );
}
