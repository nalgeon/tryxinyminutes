# bare repo
git init --bare /tmp/remote.git >/dev/null 2>&1

# sandbox repo
git clone /tmp/remote.git /tmp/repo >/dev/null 2>&1
cd /tmp/repo
echo "git is awesom" > message.txt
git add message.txt >/dev/null 2>&1
git commit -m "add message" >/dev/null 2>&1
echo "git is awesome" > message.txt
git commit -am "edit message" >/dev/null 2>&1
git push >/dev/null 2>&1

##CODE##
