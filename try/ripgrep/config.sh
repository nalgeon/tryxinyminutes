cat > /tmp/.ripgreprc << EOF
# Don't let ripgrep vomit really long lines to my terminal, and show a preview.
--max-columns=40
--max-columns-preview

# Search hidden files / directories (e.g. dotfiles) by default
--hidden

# Using glob patterns to include/exclude files or folders
--glob=!.git/*

# Because who cares about case!?
--smart-case
EOF

cd /opt/httpurr

##CODE##