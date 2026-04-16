import { UseFormSetError } from "react-hook-form";
import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import { Step } from "@/features/auth/signup/types";

export const signupMutationErrorHandling = (
  error: object,
  setStep: (arg: number) => void,
  setError: UseFormSetError<SignupSchemaType>,
) => {
  const errors = (error as unknown as Record<string, string[]>) ?? {};

  Object.entries(errors).forEach(([field, messages]) => {
    if (messages?.[0]) {
      setError(field as keyof SignupSchemaType, { message: messages[0] });
    }
  });

  const isNameStepError = ["first_name", "last_name", "username"].some(
    (field) => errors[field]?.length,
  );

  setStep(isNameStepError ? Step.NameAndUser : Step.MailAndPassword);
};
