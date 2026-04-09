import "../global.css";
import { ThemeProvider } from "@react-navigation/native";
import { PortalHost } from "@rn-primitives/portal";
import { NAV_THEME } from "@/lib/theme";
import { useColorScheme } from "@/hooks/use-color-scheme";
import * as SplashScreen from "expo-splash-screen";
import { useFonts } from "expo-font";
import { useEffect } from "react";
import { Coiny_400Regular } from "@expo-google-fonts/coiny";
import {
  configureReanimatedLogger,
  ReanimatedLogLevel,
} from "react-native-reanimated";
import { Stack } from "expo-router";
import { useAuth } from "@/features/auth";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { QueryClient } from "@tanstack/query-core";
import { QueryClientProvider } from "@tanstack/react-query";
import Toast from "react-native-toast-message";

configureReanimatedLogger({
  level: ReanimatedLogLevel.warn,
  strict: false,
});

SplashScreen.preventAutoHideAsync();
const queryClient = new QueryClient();

export default function RootLayout() {
  const { isLoggedIn } = useAuth();

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
    <GestureHandlerRootView style={{ flex: 1 }}>
      <SafeAreaProvider>
        <ThemeProvider value={NAV_THEME[resolvedColorScheme]}>
          <QueryClientProvider client={queryClient}>
            <Stack>
              <Stack.Screen name="index" options={{ headerShown: false }} />
              <Stack.Protected guard={!isLoggedIn}>
                <Stack.Screen name="welcome" options={{ headerShown: false }} />
              </Stack.Protected>
              <Stack.Protected guard={!isLoggedIn}>
                <Stack.Screen
                  name="signin"
                  options={{ headerShown: false, animation: "none" }}
                />
              </Stack.Protected>
              <Stack.Protected guard={!isLoggedIn}>
                <Stack.Screen
                  name="signup"
                  options={{ headerShown: false, animation: "none" }}
                />
              </Stack.Protected>
              <Stack.Protected guard={isLoggedIn}>
                <Stack.Screen name="home" options={{ headerShown: false }} />
              </Stack.Protected>
            </Stack>
            <PortalHost />
            <Toast />
          </QueryClientProvider>
        </ThemeProvider>
      </SafeAreaProvider>
    </GestureHandlerRootView>
  );
}
