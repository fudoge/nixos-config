---@diagnostic disable-next-line: undefined-global
local hl = hl

hl.layer_rule({ match = { namespace = "quickshell:.*" }, ignore_alpha = 0.57})

hl.layer_rule({ match = { namespace = "quickshell:bar" }, blur = true})
hl.layer_rule({ match = { namespace = "quickshell:bar" }, ignore_alpha = 0.16})

hl.layer_rule({ match = { namespace = "quickshell:sidebarRight" }, ignore_alpha = 0.87})
hl.layer_rule({ match = { namespace = "quickshell:sidebarLeft" }, ignore_alpha = 0.87})

hl.layer_rule({ match = { namespace = "notifications" }, blur = true})
hl.layer_rule({ match = { namespace = "notifications" }, ignore_alpha = 0.57})

hl.layer_rule({ match = { namespace = "quickshell:overlay" }, ignore_alpha = 0.9})
hl.layer_rule({ match = { namespace = "quickshell:popup" }, ignore_alpha = 1})
