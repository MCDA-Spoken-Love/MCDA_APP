import { AnimatedBody } from "@/features/auth/signup/components/animated/animated-body";
import { useCallback, useState } from "react";
import { Form } from "@/features/auth/signup/components/form";

export const SignupPage = () => {
  const [showForm, setShowForm] = useState<boolean>(false);

  const onAdvance = useCallback(() => {
    setShowForm(true);
  }, [setShowForm]);

  return <>{showForm ? <Form /> : <AnimatedBody onAdvance={onAdvance} />}</>;
};
