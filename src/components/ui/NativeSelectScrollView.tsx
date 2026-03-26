import { Animated, Platform } from "react-native";
import { cn } from "@/lib/utils";
import ScrollView = Animated.ScrollView;

export function NativeSelectScrollView({
  className,
  ...props
}: React.ComponentProps<typeof ScrollView>) {
  if (Platform.OS === "web") {
    return <>{props.children}</>;
  }
  return <ScrollView className={cn("max-h-52", className)} {...props} />;
}
