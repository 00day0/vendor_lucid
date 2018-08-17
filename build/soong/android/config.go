package android

// Global config used by Ozone soong additions
var OzoneConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.ozone.hardware",
	},
}
