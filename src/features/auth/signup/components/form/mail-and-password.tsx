import { Pressable, View } from "react-native";
import { Label } from "@/components/ui/label";
import { SheetInput } from "@/components/ui/sheet-input";
import { useState } from "react";
import { EyeClosedIcon, EyeIcon } from "lucide-react-native";
import { Button } from "@/components/ui/button";
import { Controller, useFormContext } from "react-hook-form";
import { SignupSchemaType } from "@/features/auth/signup/constants/schema";
import { Checkbox } from "@/components/ui/checkbox";
import { Text } from "@/components/ui/text";
import { ErrorText } from "@/components/ui/error-text";

export const MailAndPassword = () => {
  const [isVisible, setIsVisible] = useState(false);
  const { control } = useFormContext<SignupSchemaType>();

  const handleSetIsVisible = () => {
    setIsVisible(!isVisible);
  };

  return (
    <View className={"flex-col gap-4 w-full"} testID={"mail-and-password-step"}>
      <View className={"gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>Email</Label>

        <Controller
          control={control}
          name="email"
          render={({
            field: { onChange, onBlur, value },
            fieldState: { error },
          }) => (
            <View className="gap-1">
              <SheetInput
                value={value}
                onChangeText={onChange}
                onBlur={onBlur}
                keyboardType="email-address"
                textContentType="emailAddress"
                autoComplete="email"
                placeholder="Endereço de e-mail"
                aria-label={"email address"}
                testID={"email-input"}
              />
              {error && <ErrorText error={error} fieldName={"email"} />}
            </View>
          )}
        />
      </View>

      <View className={"gap-1 flex-col w-full"}>
        <Label className={"font-coiny text-2xl font-medium"}>Senha</Label>

        <Controller
          control={control}
          name="password1"
          render={({
            field: { onChange, onBlur, value },
            fieldState: { error },
          }) => (
            <View className="gap-1">
              <View className={"flex-row gap-1 items-center"}>
                <SheetInput
                  value={value}
                  onChangeText={onChange}
                  onBlur={onBlur}
                  secureTextEntry={!isVisible}
                  textContentType="newPassword"
                  autoComplete="password"
                  placeholder="Sua senha"
                  className={"flex-1"}
                  aria-label={"password"}
                  testID={"password1-input"}
                />
                <Button
                  size={"icon"}
                  variant="outline"
                  className={"p-1 h-full w-14"}
                  onPress={handleSetIsVisible}
                >
                  {isVisible ? (
                    <EyeIcon size={20} color="#666" />
                  ) : (
                    <EyeClosedIcon size={20} color="#666" />
                  )}
                </Button>
              </View>
              {error && <ErrorText error={error} fieldName={"password1"} />}
            </View>
          )}
        />

        <Controller
          control={control}
          name="password2"
          render={({
            field: { onChange, onBlur, value },
            fieldState: { error },
          }) => (
            <View className="gap-1">
              <View className={"flex-row gap-1 items-center"}>
                <SheetInput
                  value={value}
                  onChangeText={onChange}
                  onBlur={onBlur}
                  secureTextEntry={!isVisible}
                  textContentType="password"
                  autoComplete="password"
                  placeholder="Confirme sua senha"
                  aria-label={"confirm-password"}
                  className={"flex-1"}
                  testID={"password2-input"}
                />
                <Button
                  size={"icon"}
                  variant="outline"
                  className={"p-1 h-full w-14"}
                  onPress={handleSetIsVisible}
                >
                  {isVisible ? (
                    <EyeIcon size={20} color="#666" />
                  ) : (
                    <EyeClosedIcon size={20} color="#666" />
                  )}
                </Button>
              </View>
              {error && <ErrorText error={error} fieldName={"password2"} />}
            </View>
          )}
        />
      </View>

      <View className="w-full gap-3">
        <Controller
          control={control}
          name="has_accepted_terms_and_conditions"
          render={({ field: { value, onChange }, fieldState: { error } }) => {
            return (
              <View className="gap-1">
                <Pressable
                  onPress={() => onChange(!value)}
                  className="flex-row items-center gap-2"
                >
                  <Checkbox
                    checked={value}
                    onCheckedChange={onChange}
                    className="mt-0.5"
                    testID={"terms-and-conditions-checkbox"}
                  />
                  <Text className="text-sm flex-1">
                    Eu aceito os termos e condições
                  </Text>
                </Pressable>
                {error && (
                  <ErrorText
                    error={error}
                    fieldName={"has_accepted_terms_and_conditions"}
                  />
                )}
              </View>
            );
          }}
        />

        <Controller
          control={control}
          name="has_accepted_privacy_policy"
          render={({ field: { value, onChange }, fieldState: { error } }) => {
            return (
              <View className="gap-1">
                <Pressable
                  onPress={() => onChange(!value)}
                  className="flex-row items-center gap-2"
                >
                  <Checkbox
                    checked={value}
                    onCheckedChange={onChange}
                    className="mt-0.5"
                    testID={"privacy-policy-checkbox"}
                  />
                  <Text className="text-sm flex-1">
                    Eu aceito a política de privacidade
                  </Text>
                </Pressable>
                {error && (
                  <ErrorText
                    error={error}
                    fieldName={"has_accepted_privacy_policy"}
                  />
                )}
              </View>
            );
          }}
        />
      </View>
    </View>
  );
};
