import { Text } from "@/components/ui/text";
import { AuthOverlay } from "@/features/auth/components/auth-overlay";

export default function Signin() {
  return (
    <AuthOverlay data-testid={"screen-signin"} triggerAnimation>
      <Text>Login</Text>
    </AuthOverlay>
  );
}
