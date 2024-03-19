cat > /tmp/.ripgreprc << EOF
# Trim really long lines and show a preview
--max-columns=40
--max-columns-preview

# Search hidden files / directories (e.g. dotfiles)
--hidden

# Do not search git files
--glob
!.git/*

# Ignore case unless all caps
--smart-case
EOF

cd /opt/httpurr

##CODE##