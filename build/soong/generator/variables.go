package generator

import (
	"fmt"

	"android/soong/android"
)

func fiExpandVariables(ctx android.ModuleContext, in string) string {
	fiVars := ctx.Config().VendorConfig("fiVarsPlugin")

	out, err := android.Expand(in, func(name string) (string, error) {
		if fiVars.IsSet(name) {
			return fiVars.String(name), nil
		}
		// This variable is not for us, restore what the original
		// variable string will have looked like for an Expand
		// that comes later.
		return fmt.Sprintf("$(%s)", name), nil
	})

	if err != nil {
		ctx.PropertyErrorf("%s: %s", in, err.Error())
		return ""
	}

	return out
}
