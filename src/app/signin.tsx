import { Text } from "@/components/ui/text";
import { AuthOverlay } from "@/features/auth/components/auth-overlay";

export default function Signin() {
  return (
    <AuthOverlay triggerAnimation>
      <Text>Login</Text>
    </AuthOverlay>
  );
}
