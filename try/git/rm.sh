cd /tmp && mkdir repo && cd repo
git init >/dev/null 2>&1
echo "git is awesom" > message.txt
git add message.txt >/dev/null 2>&1
git commit -m "add message" >/dev/null 2>&1
##CODE##