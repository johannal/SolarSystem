# Update the UI test runner's Info.plist to reference the custom app icon
INFO_PLIST="${TARGET_BUILD_DIR}/../Info.plist"

plutil -insert CFBundleIcons -json '{ "CFBundlePrimaryIcon": { "CFBundleIconFiles" : ["Icon-60@2x", "Icon-60@3x"] } }' "${INFO_PLIST}" || true
