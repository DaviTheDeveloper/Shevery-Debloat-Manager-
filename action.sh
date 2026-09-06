#!/system/bin/sh
echo "Shevery Debloat Manager"
echo "module=$SHIZUKU_MODULE_ID"
echo "mode=$SHIZUKU_MODULE_MODE"
echo "uid=$(id)"
echo "packages=$(cmd package list packages | wc -l)"
echo "disabled=$(cmd package list packages -d --user 0 | wc -l)"
echo "uninstalled_for_user=$(cmd package list packages -u --user 0 | wc -l)"
