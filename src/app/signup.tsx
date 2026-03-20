import { SignupPage } from "@/features/auth/signup";
import { AuthOverlay } from "@/features/auth/components/auth-overlay";

export default function SignUp() {
  return (
    <AuthOverlay triggerAnimation>
      <SignupPage />
    </AuthOverlay>
  );
}
