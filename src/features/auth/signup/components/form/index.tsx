import { RefObject, useRef } from "react";
import { Step } from "@/features/auth/signup/types";
import { NameAndUser } from "@/features/auth/signup/components/form/name-and-user";
import { GenderAndSexuality } from "@/features/auth/signup/components/form/gender-and-sexuality";
import { MailAndPassword } from "@/features/auth/signup/components/form/mail-and-password";
import { Sheet } from "@/components/ui/bottom-sheet";
import { FormStepNav } from "@/features/auth/signup/components/form/form-step-nav";
import { ActivityIndicator, View } from "react-native";
import { BottomSheetMethods } from "@gorhom/bottom-sheet/src/types";
import { ProfilePicture } from "@/features/auth/signup/components/form/profile-picture";
import { UseMutationResult } from "@tanstack/react-query";
import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import { useFormContext } from "react-hook-form";
import { useTheme } from "@/hooks/use-theme";
import { isEmpty } from "lodash";
import { ErrorText } from "@/components/ui/error-text";
import { Button } from "@/components/ui/button";
import { Text } from "@/components/ui/text";

interface Props {
  step: Step;
  onAdvance: () => void;
  onReturn: () => void;
  imageUploadError: string | null;
  signupMutation: UseMutationResult<
    SignupSchemaType,
    unknown,
    SignupSchemaType
  >;
  handleNavigate: () => void;
  presignImageMutation: UseMutationResult<
    any,
    Error,
    {
      profile_picture: string;
    },
    unknown
  >;
}

export const Form = ({
  step,
  onAdvance,
  onReturn,
  imageUploadError,
  signupMutation,
  handleNavigate,
  presignImageMutation,
}: Props) => {
  const bottomSheetRef = useRef<BottomSheetMethods>(null);
  const formMethods = useFormContext<SignupSchemaType>();
  const { getValues } = formMethods;
  const colorScheme = useTheme();

  const stepComponents = {
    [Step.NameAndUser]: <NameAndUser />,
    [Step.GenderAndSexuality]: <GenderAndSexuality />,
    [Step.ProfilePicture]: <ProfilePicture />,
    [Step.MailAndPassword]: <MailAndPassword />,
  };

  const handleTryUpload = async (): Promise<void> => {
    await presignImageMutation.mutateAsync({
      profile_picture: getValues().profile_picture as string,
    });
  };

  return (
    <Sheet
      hasHandle={false}
      sheetRef={bottomSheetRef as RefObject<BottomSheetMethods>}
    >
      <View className={"flex-col gap-6"} testID={"signup-form"}>
        {!isEmpty(imageUploadError) ? (
          <View className={"items-center flex-col gap-6"}>
            <ErrorText
              className={"text-center text-2xl"}
              error={{ message: imageUploadError as string }}
              fieldName={"profile_picture"}
            />
            <Button size="full" className={"text-xs"} onPress={handleTryUpload}>
              {presignImageMutation.isPending ? (
                <ActivityIndicator
                  size="small"
                  color={colorScheme.background}
                />
              ) : null}
              <Text>Tentar novamente</Text>
            </Button>
            <Button
              size="lg"
              className="w-full"
              variant="outline"
              onPress={handleNavigate}
            >
              <Text>Concluir cadastro e adicionar imagem depois</Text>
            </Button>
          </View>
        ) : (
          <>
            {stepComponents[step as keyof typeof stepComponents]}
            <FormStepNav
              step={step}
              onAdvance={onAdvance}
              isLoading={signupMutation.isPending}
              onReturn={onReturn}
            />
          </>
        )}
      </View>
    </Sheet>
  );
};
