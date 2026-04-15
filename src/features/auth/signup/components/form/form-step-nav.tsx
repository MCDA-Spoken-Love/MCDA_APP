import { ActivityIndicator, View } from "react-native";
import { Button } from "@/components/ui/button";
import { Text } from "@/components/ui/text";
import { useTheme } from "@/hooks/use-theme";

interface FormStepNavProps {
  step: number;
  isLoading?: boolean;
  onAdvance: () => void;
  onReturn: () => void;
}

export const FormStepNav = ({
  step,
  isLoading = false,
  onReturn,
  onAdvance,
}: FormStepNavProps) => {
  const colorScheme = useTheme();
  const step2And3Component = (
    <View className={"flex-1 gap-1 w-full"}>
      <Button
        variant="outline"
        size="full"
        onPress={onReturn}
        testID={"return-input"}
      >
        <Text className="font-coiny">Voltar</Text>
      </Button>
      <Button size="full" onPress={onAdvance} testID={"advance-input"}>
        <Text className="font-coiny">Avançar</Text>
      </Button>
    </View>
  );

  const formStep = {
    1: (
      <View className={"flex-1 justify-between w-full"}>
        <Button size="full" onPress={onAdvance} testID={"advance-input"}>
          <Text className="font-coiny">Avançar</Text>
        </Button>
      </View>
    ),
    2: step2And3Component,
    3: step2And3Component,
    4: (
      <View className={"flex-1 gap-1  w-full"}>
        <Button
          variant="outline"
          size="full"
          onPress={onReturn}
          testID={"return-input"}
        >
          <Text className="font-coiny">Voltar</Text>
        </Button>
        <Button size="full" onPress={onAdvance} testID={"advance-input"}>
          {isLoading ? (
            <ActivityIndicator size="small" color={colorScheme.background} />
          ) : null}
          <Text className="font-coiny">Criar conta</Text>
        </Button>
      </View>
    ),
  };

  return <View>{formStep[step as keyof typeof formStep]}</View>;
};
