import "../global.css";
import { ThemeProvider } from "@react-navigation/native";
import { PortalHost } from "@rn-primitives/portal";
import { NAV_THEME } from "@/lib/theme";
import { useColorScheme } from "@/hooks/use-color-scheme";
import * as SplashScreen from "expo-splash-screen";
import Routing from "@/app/routing";
import { useFonts } from "expo-font";
import { useEffect } from "react";
import { Coiny_400Regular } from "@expo-google-fonts/coiny";
import { configureReanimatedLogger, ReanimatedLogLevel } from "react-native-reanimated";

configureReanimatedLogger({
  level: ReanimatedLogLevel.warn,
  strict: false,
});

SplashScreen.preventAutoHideAsync();

export default function RootLayout() {
  const colorScheme = useColorScheme();
  const resolvedColorScheme = colorScheme === "dark" ? "dark" : "light";
  const [loaded] = useFonts({
    Besty_Beige: require("../../assets/fonts/Besty_Beige.ttf"),
    "Coiny-Regular": Coiny_400Regular,
  });

  useEffect(() => {
    if (loaded) {
      SplashScreen.hideAsync();
    }
  }, [loaded]);

  if (!loaded) return null;

  return (
    <ThemeProvider value={NAV_THEME[resolvedColorScheme]}>
      <Routing />
      <PortalHost />
    </ThemeProvider>
  );
}
