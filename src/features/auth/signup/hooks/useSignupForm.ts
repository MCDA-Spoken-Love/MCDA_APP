import {
  SignupSchema,
  SignupSchemaType,
} from "@/features/auth/signup/constants/schema";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useCallback, useMemo, useState } from "react";
import { Step } from "@/features/auth/signup/components/types";

export const useSignupForm = () => {
  const [step, setStep] = useState<Step>(Step.NameAndUser);
  const formMethods = useForm<SignupSchemaType>({
    resolver: zodResolver(SignupSchema),
    mode: "all",
    defaultValues: {
      gender: null,
      sexuality: null,
      has_accepted_terms_and_conditions: false,
      has_accepted_privacy_policy: false,
    },
  });

  const stepFieldsMap: Record<Step, (keyof SignupSchemaType)[]> = useMemo(
    () => ({
      [Step.NameAndUser]: ["first_name", "last_name", "username"],
      [Step.GenderAndSexuality]: ["gender", "sexuality"],
      [Step.MailAndPassword]: [
        "email",
        "password1",
        "password2",
        "has_accepted_privacy_policy",
        "has_accepted_terms_and_conditions",
      ],
    }),
    [],
  );

  const onAdvance = useCallback(async () => {
    const fieldsToValidate = stepFieldsMap[step] || [];
    const isStepValid = await formMethods.trigger(
      fieldsToValidate as (keyof SignupSchemaType)[],
      { shouldFocus: true },
    );

    if (step !== Step.MailAndPassword) {
      if (isStepValid) {
        return setStep((prev) => prev + 1);
      }
      return;
    }

    if (isStepValid) {
      return onSubmit();
    }

    return;
  }, [formMethods, step, stepFieldsMap]);

  const onReturn = useCallback(() => {
    setStep((prev) => prev - 1);
  }, [setStep]);

  const onSubmit = () => {
    console.log("aaa");
  };

  return { formMethods, onSubmit, onAdvance, onReturn, step };
};
