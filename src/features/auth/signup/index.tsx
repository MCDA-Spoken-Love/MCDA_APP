import { AnimatedBody } from "@/features/auth/signup/components/animated/animated-body";
import { useCallback, useState } from "react";
import { Form } from "@/features/auth/signup/components/form";
import { useSignupForm } from "@/features/auth/signup/hooks/useSignupForm";
import { FormProvider } from "react-hook-form";

export const SignupPage = () => {
  const [showForm, setShowForm] = useState<boolean>(false);
  const useSignupFormHook = useSignupForm();

  const onAdvance = useCallback(() => {
    setShowForm(true);
  }, [setShowForm]);

  return (
    <>
      {showForm ? (
        <FormProvider {...useSignupFormHook.formMethods}>
          <Form {...useSignupFormHook} />
        </FormProvider>
      ) : (
        <AnimatedBody onAdvance={onAdvance} />
      )}
    </>
  );
};
