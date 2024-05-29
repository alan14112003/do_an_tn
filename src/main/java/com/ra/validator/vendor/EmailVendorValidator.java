package com.ra.validator.vendor;

import com.ra.model.repository.BrandRepository;
import com.ra.model.repository.VendorRepository;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class EmailVendorValidator implements ConstraintValidator<EmailVendorUnique, String> {
    private final VendorRepository vendorRepository;

    @Override
    public boolean isValid(String string, ConstraintValidatorContext constraintValidatorContext) {
        return !vendorRepository.existsByEmail(string);
    }
}
