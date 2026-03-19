import { Stack } from "expo-router";

const isLoggedIn = false;

export default function Routing() {
  return (
    <Stack>
      <Stack.Protected guard={!isLoggedIn}>
        <Stack.Screen name="onboarding" options={{ headerShown: false }} />
      </Stack.Protected>

      <Stack.Protected guard={isLoggedIn}>
        <Stack.Screen name="private" />
      </Stack.Protected>
    </Stack>
  );
}
