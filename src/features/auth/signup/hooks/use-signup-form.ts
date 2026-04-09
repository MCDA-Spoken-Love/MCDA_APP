import {
  SignupSchema,
  SignupSchemaType,
} from "@/features/auth/signup/constants/schema";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useCallback, useMemo, useState } from "react";
import { Step } from "@/features/auth/signup/types";
import { useMutation } from "@tanstack/react-query";
import { signupServices } from "@/features/auth/signup/services";
import { signupMutationErrorHandling } from "@/features/auth/signup/utils";
import { AxiosError } from "axios";
import { generateUniqueFilename, showToast } from "@/lib/utils";
import { UrlSignature } from "@/types";
import { saveData } from "@/lib/storage";
import { isEmpty } from "lodash";
import { router } from "expo-router";

export const useSignupForm = () => {
  const [step, setStep] = useState<Step>(Step.NameAndUser);
  const [imageUploadError, setImageUploadError] = useState<string | null>(null);
  const formMethods = useForm<SignupSchemaType>({
    resolver: zodResolver(SignupSchema),
    mode: "all",
    defaultValues: {
      has_accepted_terms_and_conditions: false,
      has_accepted_privacy_policy: false,
    },
  });

  const stepFieldsMap: Record<Step, (keyof SignupSchemaType)[]> = useMemo(
    () => ({
      [Step.NameAndUser]: ["first_name", "last_name", "username"],
      [Step.GenderAndSexuality]: ["gender", "sexuality"],
      [Step.ProfilePicture]: ["profile_picture"],
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

  const onReturn = useCallback(() => {
    setStep((prev) => prev - 1);
  }, [setStep]);

  const handleNavigate = () => {
    showToast({
      type: "success",
      position: "top",
      title: "Cadastro realizado com sucesso!",
    });
    return router.navigate("/home");
  };

  const handleImageError = (errorMessage: string) => {
    setImageUploadError(errorMessage);
    return showToast({
      type: "error",
      title: "Não foi possível fazer o upload de sua imagem de perfil",
    });
  };

  const presignImageMutation = useMutation({
    mutationFn: async ({ profile_picture }: { profile_picture: string }) => {
      const cleanFilename = generateUniqueFilename(profile_picture);

      return await signupServices.presignProfilePictureUpload(
        cleanFilename,
        process.env.EXPO_PUBLIC_CLOUDINARY_PROFILE_PICTURE_PRESET || "",
      );
    },
    onSuccess: async (data, variables) => {
      await uploadImageToSignedParameters.mutateAsync({
        profile_picture: variables.profile_picture,
        signedParams: data,
      });
    },
    onError: () => {
      handleImageError("Erro ao enviar imagem para o servidor de arquivos");
    },
  });

  const uploadImageToSignedParameters = useMutation({
    mutationFn: ({
      profile_picture,
      signedParams,
    }: {
      profile_picture: string;
      signedParams: UrlSignature;
    }) =>
      signupServices.uploadPresignedProfilePicture(
        signedParams,
        profile_picture,
      ),
    onSuccess: async (data) => {
      await updateUserWithProfilePicture.mutateAsync({
        profile_picture: data?.secure_url,
      });
    },
    onError: () => {
      handleImageError("Erro ao enviar imagem para o servidor de arquivos");
    },
  });

  const updateUserWithProfilePicture = useMutation({
    mutationFn: async ({ profile_picture }: { profile_picture: string }) => {
      await signupServices.updateUserWithProfilePicture(profile_picture);
    },
    onSuccess: async () => {
      handleNavigate();
    },
    onError: () => {
      handleImageError("Erro ao atualizar perfil com a imagem");
    },
  });

  const signupMutation = useMutation({
    mutationFn: (data: SignupSchemaType) => signupServices.signup(data),
    onSuccess: async (data) => {
      await saveData("access_token", data.access);

      await new Promise((resolve) => setTimeout(resolve, 1000));

      if (!isEmpty(formMethods.getValues().profile_picture)) {
        return presignImageMutation.mutateAsync({
          profile_picture: formMethods.getValues().profile_picture || "",
        });
      }
      return handleNavigate();
    },
    onError: (error: AxiosError) => {
      if (error.response?.data) {
        signupMutationErrorHandling(
          error?.response?.data as AxiosError,
          setStep,
          formMethods.setError,
        );
        return showToast({
          type: "error",
          title: (error?.response?.data as AxiosError)?.message,
        });
      }

      return showToast({
        type: "error",
        title: "Algo deu errado",
        description: "Um erro desconhecido aconteceu. Tente novamente",
      });
    },
  });

  const onSubmit = useCallback(async () => {
    await signupMutation.mutateAsync({
      ...formMethods.getValues(),
    });
  }, [formMethods, signupMutation]);

  const onAdvance = useCallback(async () => {
    const fieldsToValidate = stepFieldsMap[step] || [];
    const isStepValid = await formMethods.trigger(fieldsToValidate, {
      shouldFocus: true,
    });

    if (step !== Step.MailAndPassword && isStepValid) {
      return setStep((prev) => prev + 1);
    }

    if (step === Step.MailAndPassword && isStepValid) {
      return onSubmit();
    }

    return;
  }, [formMethods, step, stepFieldsMap, onSubmit]);

  return {
    formMethods,
    onSubmit,
    onAdvance,
    onReturn,
    step,
    signupMutation,
    imageUploadError,
    handleNavigate,
    presignImageMutation,
  };
};
