import { Redirect } from "expo-router";
import { useAuth } from "@/features/auth";

export default function HomeScreen() {
  const { isLoggedIn } = useAuth();
  return <Redirect href={isLoggedIn ? "/home" : "/welcome"} />;
}
