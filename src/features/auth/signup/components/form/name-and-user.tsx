import { View } from "react-native";
import { SheetInput } from "@/components/ui/sheet-input";
import { Label } from "@/components/ui/label";

export const NameAndUser = () => {
  return (
    <View className={"flex-1 flex-col items-center justify-center gap-6"}>
      <View className={"flex-1 gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>
          Diga seu nome
        </Label>
        <SheetInput
          keyboardType="name-phone-pad"
          textContentType="givenName"
          autoComplete="given-name"
          placeholder="Primeiro nome"
          aria-label={"given name"}
        />
        <SheetInput
          keyboardType="name-phone-pad"
          textContentType="familyName"
          autoComplete="family-name"
          placeholder="Sobrenome"
          aria-label={"family name"}
        />
      </View>
      <View className={"flex-1 gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>
          Seu username
        </Label>
        <SheetInput
          keyboardType="name-phone-pad"
          textContentType="username"
          autoComplete="username"
          placeholder="Nome de usuário"
          aria-label={"username"}
        />
      </View>
    </View>
  );
};
