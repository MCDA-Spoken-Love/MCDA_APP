import { WelcomePage } from "@/features/auth";
import { AuthOverlay } from "@/features/auth/components/auth-overlay";

export default function welcome() {
  return (
    <AuthOverlay data-testid={"screen-welcome"}>
      <WelcomePage />
    </AuthOverlay>
  );
}
