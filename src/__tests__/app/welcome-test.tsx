import { WelcomePage } from "@/features/auth";
import { render, screen, userEvent } from "@testing-library/react-native";
import { router } from "expo-router";

jest.mock("@/features/auth/components/auth-overlay", () => ({
  AuthOverlay: ({ children }: { children: React.ReactNode }) => <>{children}</>,
}));

jest.mock("expo-router", () => ({
  router: {
    push: jest.fn(),
    prefetch: jest.fn(),
  },
}));

describe("<WelcomePage />", () => {
  it("renders correctly", () => {
    render(<WelcomePage />);

    expect(WelcomePage).toBeDefined();
    expect(screen.getByTestId("screen-welcome")).toBeTruthy();
  });

  it("expects login button to say login", async () => {
    render(<WelcomePage />);
    const loginButton = screen.getByText("Login");

    expect(loginButton).toHaveTextContent("Login");
  });

  it("redirects to signin page on login button press", async () => {
    const user = userEvent.setup();

    render(<WelcomePage />);
    const loginButton = screen.getByText("Login");
    await user.press(loginButton);

    expect(router.push).toHaveBeenCalledWith("/signin");
  });

  it("expects login button to say login", async () => {
    render(<WelcomePage />);
    const registerButton = screen.getByText("Criar conta");

    expect(registerButton).toHaveTextContent("Criar conta");
  });

  it("redirects to signup page on register button press", async () => {
    const user = userEvent.setup();

    render(<WelcomePage />);
    const registerButton = screen.getByText("Criar conta");
    await user.press(registerButton);

    expect(router.push).toHaveBeenCalledWith("/signup");
  });
});
