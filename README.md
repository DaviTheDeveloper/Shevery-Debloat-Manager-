Shevery Debloat Manager

ADB module for Shevery/Shizuku.
## Resources

- Dynamically lists user 0 packages, including system packages removed only for the user.
Dynamic classification by origin and risk:
- **Recommended**: apps installed by the user/third parties.
- **Advanced**: bloat and optional components known to the manufacturer, as well as dynamically detected non-core OEM components.
- **Smart**: apps/system components that require review because they can remove functions used.
- **Unsafe**: critical/protected components, blocked for destructive actions.
- Detects the manufacturer by 'ro.product.manufacturer' and 'ro.product.brand' and recognizes common OEM namespaces.
- Search and filters by category and status:
- Installed/activated
- Deactivated
- Uninstalled
- Counters by category and by filters currently applied.
- Disable, activate, uninstall, and restore compatible packages.
- Mass actions only on truly eligible packages in current filters.
- Protection against destructive actions in critical components.
- Local catalog in 'data/catalog.json' used for known exceptions/descriptions.
- Uses 'pm uninstall -k --user 0' and, for existing system packages, 'pm install-existing --user 0'.
- No root required: Uses Shevery's WebUI bridge with active Shizuku.

## Structure

'module.prop', 'action.sh', 'banner.png', 'data/' and 'webui/index.html'.

The format follows the official Shevery documentation: 'module.prop' at the root, WebUI in 'webui/index.html', and 'usesShellBridge=true' for access to 'window. Shizuku'.

## Important

The category indicates the recommended level of attention, not a universal guarantee that removing a package is safe on every device/ROM. Unknown OEM packages with central function signals are in **Smart**, not **Advanced**.

Apps installed by the user are classified as **Recommended** because they are non-system apps, but uninstalling them can remove the APK altogether. In this case, 'pm install-existing' usually cannot restore them. To maintain reversibility, prefer **Disable**.

## Recovery

- Disabled -> 'pm enable --user 0 package'
- System package uninstalled only for the user -> 'pm install-existing --user 0 package'

The module does not physically erase APKs from the system partition.


## Safety and robustness fixes - 1.2.1

- 'pm' commands receive the package identifiers with secure quoting before they are sent to the shell.
The interface does not inject package names into onclick handlers; the buttons use internal indexes and listeners.
- The window bridge. Shizuku.exec() accepts in object or JSON responses and fails in a controlled manner when the response is invalid.
Catalog and protection list are validated during loading and HTTP errors are not silently accepted.
- Actions received by the interface go through an explicit list of permitted operations.