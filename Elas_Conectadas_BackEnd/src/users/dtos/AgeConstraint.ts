import {
  registerDecorator,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from 'class-validator';
import { differenceInYears, isValid, parse } from 'date-fns';

@ValidatorConstraint({ async: false })
export class AgeConstraint implements ValidatorConstraintInterface {
  validate(dob: string) {
    // Parse the date in 'dd/MM/yyyy' format (Brazilian format: DD/MM/AAAA)
    const birthDate = parse(dob, 'dd/MM/yyyy', new Date());

    // Check if the parsed date is valid
    if (!isValid(birthDate)) {
      return false; // Invalid date format
    }

    const age = differenceInYears(new Date(), birthDate);
    return age >= 18; // Return true if 18 or older
  }

  defaultMessage() {
    return 'O usuário deve ter pelo menos 18 anos de idade e fornecer uma data válida (DD/MM/AAAA).';
  }
}

// Decorator function to use in DTOs
export function IsAdult(validationOptions?: ValidationOptions) {
  return function (object: object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName,
      options: validationOptions,
      constraints: [],
      validator: AgeConstraint,
    });
  };
}
