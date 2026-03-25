import { View } from "react-native";
import { Label } from "@/components/ui/label";
import { SheetInput } from "@/components/ui/sheet-input";
import { useState } from "react";
import { EyeClosedIcon, EyeIcon } from "lucide-react-native";
import { Button } from "@/components/ui/button";

export const MailAndPassword = () => {
  const [isVisible, setIsVisible] = useState(false);

  const handleSetIsVisible = () => {
    setIsVisible(!isVisible);
  };

  return (
    <View className={"flex-1 flex-col items-center justify-center gap-6"}>
      <View className={"flex-1 gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>Email</Label>
        <SheetInput
          keyboardType="email-address"
          textContentType="emailAddress"
          autoComplete="email"
          placeholder="Endereço de e-mail"
          aria-label={"email address"}
        />
      </View>
      <View className={"flex-1 gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>Senha</Label>
        <View className={"flex-1 flex-row gap-1 items-center"}>
          <SheetInput
            secureTextEntry={!isVisible}
            textContentType="newPassword"
            autoComplete="password"
            placeholder="Sua senha"
            className={"flex-1"}
            aria-label={"password"}
          />
          <Button
            size={"icon"}
            variant="outline"
            className={"p-1"}
            onPress={handleSetIsVisible}
          >
            {isVisible ? (
              <EyeIcon size={20} color="#666" />
            ) : (
              <EyeClosedIcon size={20} color="#666" />
            )}
          </Button>
        </View>
        <View className={"flex-1 flex-row gap-1 items-center"}>
          <SheetInput
            secureTextEntry={!isVisible}
            textContentType="password"
            autoComplete="password"
            placeholder="Confirme sua senha"
            aria-label={"confirm-password"}
            className={"flex-1"}
          />
          <Button
            size={"icon"}
            variant="outline"
            className={"p-1"}
            onPress={handleSetIsVisible}
          >
            {isVisible ? (
              <EyeIcon size={20} color="#666" />
            ) : (
              <EyeClosedIcon size={20} color="#666" />
            )}
          </Button>
        </View>
      </View>
    </View>
  );
};
