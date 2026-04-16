import { signupMutationErrorHandling } from "@/features/auth/signup/utils";
import { Step } from "@/features/auth/signup/types";

describe("signup utils", () => {
  describe("signupMutationErrorHandling", function () {
    let mockSetStep: jest.Mock;
    let mockSetError: jest.Mock;

    beforeEach(() => {
      mockSetStep = jest.fn();
      mockSetError = jest.fn();
    });

    it("should set error for first_name and set step to NameAndUser", () => {
      const error = {
        first_name: ["First name is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("first_name", {
        message: "First name is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.NameAndUser);
    });

    it("should set error for last_name and set step to NameAndUser", () => {
      const error = {
        last_name: ["Last name is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("last_name", {
        message: "Last name is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.NameAndUser);
    });

    it("should set error for username and set step to NameAndUser", () => {
      const error = {
        username: ["username is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("username", {
        message: "username is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.NameAndUser);
    });

    it("should set error for email and set step to MailAndPassword", () => {
      const error = {
        email: ["email is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("email", {
        message: "email is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.MailAndPassword);
    });

    it("should set error for password1 and set step to MailAndPassword", () => {
      const error = {
        password1: ["password1 is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("password1", {
        message: "password1 is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.MailAndPassword);
    });

    it("should set error for password2 and set step to MailAndPassword", () => {
      const error = {
        password2: ["password2 is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("password2", {
        message: "password2 is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.MailAndPassword);
    });

    it("should should handle multiple errors for NameAndUser", () => {
      const error = {
        first_name: ["First name is required"],
        last_name: ["Last name is required"],
        username: ["username is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("first_name", {
        message: "First name is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("last_name", {
        message: "Last name is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("username", {
        message: "username is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.NameAndUser);
    });

    it("should should handle multiple errors for MailAndPassword", () => {
      const error = {
        email: ["email is required"],
        password1: ["password1 is required"],
        password2: ["password2 is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("email", {
        message: "email is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("password1", {
        message: "password1 is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("password2", {
        message: "password2 is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.MailAndPassword);
    });

    it("should should handle multiple errors and direct to the correct step", () => {
      const error = {
        first_name: ["First name is required"],
        last_name: ["Last name is required"],
        username: ["username is required"],
        email: ["email is required"],
        password1: ["password1 is required"],
        password2: ["password2 is required"],
      };

      signupMutationErrorHandling(error, mockSetStep, mockSetError);

      expect(mockSetError).toHaveBeenCalledWith("first_name", {
        message: "First name is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("last_name", {
        message: "Last name is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("username", {
        message: "username is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("email", {
        message: "email is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("password1", {
        message: "password1 is required",
      });
      expect(mockSetError).toHaveBeenCalledWith("password2", {
        message: "password2 is required",
      });
      expect(mockSetStep).toHaveBeenCalledWith(Step.NameAndUser);
    });
  });
});
