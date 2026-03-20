import { Stack } from "expo-router";
import { useAuth } from "@/features/auth";

export const Routing = () => {
  const { isLoggedIn } = useAuth();

  return (
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
  );
};
