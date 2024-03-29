cd /tmp && mkdir repo && cd repo
git init >/dev/null 2>&1

cat <<'EOF' >> test.sh
#!/bin/sh
output=$(sh main.sh 40 2)
if [ "$output" -ne 42 ]; then
  echo "FAIL"
  exit 1
fi
echo "PASS"
exit 0
EOF
git add test.sh
git commit -m "test.sh" >/dev/null 2>&1

echo "echo 42" > main.sh
git add main.sh >/dev/null 2>&1
git commit -m "main.sh" >/dev/null 2>&1

echo 'echo $(expr $1 + $2)' > main.sh
git commit -am "main.sh" >/dev/null 2>&1

echo '# sum two numbers' > main.sh
echo 'echo $(expr $1 + $2)' >> main.sh
git commit -am "main.sh" >/dev/null 2>&1

echo '# sum two numbers' > main.sh
echo 'echo $(expr $1 - $2)' >> main.sh
git commit -am "main.sh" >/dev/null 2>&1

echo '# Sum two numbers:' > main.sh
echo 'echo $(expr $1 - $2)' >> main.sh
git commit -am "main.sh" >/dev/null 2>&1

##CODE##