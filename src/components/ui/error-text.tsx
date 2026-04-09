import { Text } from "@/components/ui/text";
import { cn } from "@/lib/utils";

import { FieldError } from "react-hook-form";

type Props = {
  className?: string;
  fieldName: string;
  error: Partial<FieldError> | undefined;
};

export const ErrorText = ({ error, fieldName, className = "" }: Props) => {
  if (!error) return null;

  return (
    <Text
      testID={`error-${fieldName}`}
      className={cn("text-sm text-destructive", className)}
    >
      {error?.message as string}
    </Text>
  );
};
