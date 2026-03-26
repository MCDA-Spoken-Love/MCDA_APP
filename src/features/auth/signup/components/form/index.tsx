import { RefObject, useRef } from "react";
import { Step } from "@/features/auth/signup/components/types";
import { NameAndUser } from "@/features/auth/signup/components/form/name-and-user";
import { GenderAndSexuality } from "@/features/auth/signup/components/form/gender-and-sexuality";
import { MailAndPassword } from "@/features/auth/signup/components/form/mail-and-password";
import { Sheet } from "@/components/ui/bottom-sheet";
import { FormStepNav } from "@/features/auth/signup/components/form/form-step-nav";
import { View } from "react-native";
import { BottomSheetMethods } from "@gorhom/bottom-sheet/src/types";

interface Props {
  step: Step;
  onAdvance: () => void;
  onSubmit: () => void;
  onReturn: () => void;
}

export const Form = ({ step, onAdvance, onReturn, onSubmit }: Props) => {
  const bottomSheetRef = useRef<BottomSheetMethods>(null);

  const stepComponents = {
    [Step.NameAndUser]: <NameAndUser />,
    [Step.GenderAndSexuality]: <GenderAndSexuality />,
    // [Step.ProfilePicture]: <ProfilePicture />,
    [Step.MailAndPassword]: <MailAndPassword />,
  };

  return (
    <Sheet
      hasHandle={false}
      sheetRef={bottomSheetRef as RefObject<BottomSheetMethods>}
    >
      <View className={"flex-1 flex-col gap-6"}>
        {stepComponents[step as keyof typeof stepComponents]}
        <FormStepNav
          step={step}
          onAdvance={onAdvance}
          onReturn={onReturn}
          onSubmit={onSubmit}
        />
      </View>
    </Sheet>
  );
};
