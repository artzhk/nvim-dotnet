# Dotnet enabled nvim config with Roslyn
Minimal workable Roslyn lsp based configuration. 

## Issues
Check `:lua print(vim.lsp.get_log_path())`, in the case of 
``` bash 
ERROR][2026-01-26 09:16:12] ...lsp/handlers.lua:562 "[solution/open] [LanguageServerProjectLoader] Error while loading /home/__/repos/{path to your .csproj}:
Exception thrown: System.IO.IOException: The configured user limit (128) on the number of inotify instances has been reached, or the per-process limit on the number of open file descriptors has been reached.
```

Roslyn relies on /inotify/ mechanism to keep track of events for a set of monitored files and directories.

### **/inotify/ limit**

Chek if the limit is low
``` bash
cat /proc/sys/fs/inotify/max_user_instances
cat /proc/sys/fs/inotify/max_user_watches
ulimit -n
```
 
Persistanly change to higher limit
``` bash
sudo tee /etc/sysctl.d/99-inotify.conf >/dev/null <<'EOF'
fs.inotify.max_user_instances=1024
fs.inotify.max_user_watches=524288
EOF
sudo sysctl --system
```
