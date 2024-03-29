# bare repo
git init --bare /tmp/remote.git >/dev/null 2>&1

# sandbox repo
git clone /tmp/remote.git /tmp/repo >/dev/null 2>&1
cd /tmp/repo
echo "git is awesom" > message.txt
git add message.txt >/dev/null 2>&1
git commit -m "add message" >/dev/null 2>&1
git push >/dev/null 2>&1

# alice repo
git clone /tmp/remote.git /tmp/alice >/dev/null 2>&1
cd /tmp/alice
git config user.email alice@example.com
git config user.name "Alice Zakas"
echo "Git is awesome!" > message.txt
git commit -am "edit from alice" >/dev/null 2>&1
git push >/dev/null 2>&1

# back to sandbox repo
cd /tmp/repo

##CODE##